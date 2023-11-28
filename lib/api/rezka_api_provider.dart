import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:kgino/enums/online_service.dart';
import 'package:kgino/extensions/string.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/media_item.dart';
import '../models/rezka/rezka_item.dart';
import '../models/tskg/tskg_item.dart';
import '../models/voice_acting.dart';
import '../providers/providers.dart';
import 'interceptors/logs_interceptor.dart';
import 'models/api_request.dart';
import 'tskg_isolates.dart';

part 'rezka_api_provider.g.dart';

@Riverpod(keepAlive: true)
RezkaApi rezkaApi(RezkaApiRef ref) => RezkaApi(ref);

class RezkaApi {
  final RezkaApiRef ref;

  CancelToken getCancelToken() => CancelToken();

  // static final userAgent =
  //     'KGino/${kIsWeb ? 'Web' : Platform.operatingSystem} ${kIsWeb ? 'Web' : Platform.operatingSystemVersion}';

  final _dio = Dio(BaseOptions(
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      // 'User-Agent': userAgent,
    },
  ));

  RezkaApi(this.ref) {
    /// добавляем перехватчик, для логов запросов
    _dio.interceptors.add(LogsInterceptor());

    /// хранилище данных
    final storage = ref.read(storageProvider);

    String baseUrl =
        storage.sharedStorage.getString('rezka_url') ?? 'https://rezka.ag';

    _dio.options.baseUrl = baseUrl;
  }

  // /// формируем полную ссылку на постер сериала по id
  // String getPosterUrlById(String showId) {
  //   return '${_dio.options.baseUrl}/posters/$showId.png';
  // }

  // /// формируем полную ссылку на сериал по id
  // String getShowUrlById(String showId) {
  //   return '${_dio.options.baseUrl}/show/$showId';
  // }

  // /// список последних поступлений
  // Future<List<MediaItem>> getLastEpisodes() async {
  //   return ApiRequest<List<MediaItem>>().call(
  //     request: _dio.get('/news'),
  //     decoder: (response) async {
  //       final html = response.toString();

  //       final items = <MediaItem>[];

  //       /// парсим html
  //       final document = parse(html);

  //       /// получаем элементы списка новых поступлений
  //       final elements = document.getElementsByClassName('app-news-block');

  //       for (final element in elements) {
  //         /// парсим дату добавления
  //         /// <div class="app-news-date"><strong>22.12.2021</strong></div>
  //         final dateText =
  //             element.getElementsByClassName('app-news-date').first.text;
  //         final date = DateFormat('dd.MM.yyyy').parse(dateText);

  //         /// парсим элементы новых поступлений
  //         /*
  //           <div class="app-news-list-item">
  //               <div class="clearfix news">
  //                 <i class="fas fa-caret-right"></i>
  //               <span class="label label-default"><span class="fas fa-sync-alt" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Обновлено"></span></span>
  //               <a class="news-link app-news-link" href="/show/zhenskii_stand_up/3/16" data-toggle="tooltip" data-placement="top" title="ТВ-шоу (российские), Стендап, Юмористическое шоу">Женский стендап</a>
  //               <span class="text-muted clearfix"><small>3 сезон, 16 серия</small></span>
  //             </div>
  //           </div>
  //         */
  //         final listItems =
  //             element.getElementsByClassName('app-news-list-item');
  //         for (final listItem in listItems) {
  //           //debugPrint('date: $DateFormat');

  //           final tagsA = listItem.getElementsByClassName('app-news-link');
  //           if (tagsA.isNotEmpty) {
  //             /// ^ если в новостях найден элемент <a></a>

  //             final tagA = tagsA.first;

  //             final tagSmall = listItem.getElementsByTagName('small');

  //             /// ссылка на сериал/подборку/серию
  //             final link = tagA.attributes['href'] ?? '';
  //             //debugPrint('link: $link');

  //             /// название сериала или подборки
  //             final title = tagA.text;
  //             //debugPrint('title: $title');

  //             /// дополнительная информация (например, сезон и номер серии)
  //             String subtitle = '';
  //             if (tagSmall.isNotEmpty) {
  //               subtitle = tagSmall.first.text;
  //             }

  //             /// жанры
  //             final genres = (tagA.attributes['title'] ?? '').split(', ');
  //             // debugPrint('genres: $genres');

  //             // /// значки (badges)
  //             // final badges = listItem.getElementsByClassName('label').map((badge) {

  //             //   if (badge.text.isEmpty) {
  //             //     /// ^ если значок в виде иконки
  //             //     return badge.firstChild?.attributes['title'] ?? '';

  //             //   } else {
  //             //     /// ^ если значок подписан

  //             //     return badge.text;

  //             //   }

  //             // });

  //             final id = TskgItem.getShowIdFromUrl(link);
  //             if (id.isNotEmpty) {
  //               items.add(TskgItem(
  //                 id: id,
  //                 title: title,
  //                 //subtitle: subtitle,
  //                 genres: genres,
  //               ));
  //             }
  //           }
  //         }
  //       }

  //       return items;
  //     },
  //   );
  // }

  /// список новых сериалов
  Future<List<MediaItem>> getLatestShows() async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/series/page/1/?filter=last'),
      decoder: (response) async {
        final html = response.toString();

        /// список элементов
        final items = <MediaItem>[];

        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(html);

        /// получаем элементы списка популярных
        final elements =
            document.getElementsByClassName('b-content__inline_item');

        for (final element in elements) {
          // <div class="b-content__inline_item" data-id="64013" data-url="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html">
          //   <div class="b-content__inline_item-cover"> <a href="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html"> <img src="http://static.rezka.cloud/i/2023/11/15/p608f1813f7e3yk66h87r.jpg" height="250" width="166" alt="Смотреть Новые уловки онлайн в HD качестве 720p" /> <span class="cat series"><i class="entity">Сериал</i><i class="icon"></i></span> <span class="info">Завершен (все серии)</span> <i class="i-sprt play"></i> </a> <i class="trailer show-trailer" data-id="64013" data-full="1"><b>Смотреть трейлер</b></i> </div>
          //   <div class="b-content__inline_item-link"> <a href="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html">Новые уловки</a>
          //     <div>2003-2015, Великобритания, Детективы</div>
          //   </div>
          // </div>

          /// парсим ссылку
          final id = element.attributes['data-id'] ?? '';
          final posterUrl = element
                  .getElementsByTagName('img')
                  .firstOrNull
                  ?.attributes['src'] ??
              '';
          final link = element
              .getElementsByClassName('b-content__inline_item-link')
              .first;

          /// парсим название
          final title = link.getElementsByTagName('a').first.text;

          items.add(RezkaItem(
            id: id,
            title: title,
            poster: posterUrl,
          ));
        }

        return items;
      },
    );
  }

  /// список новых фильмов
  Future<List<MediaItem>> getLatestMovies() async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/films/page/1/?filter=last'),
      decoder: (response) async {
        final html = response.toString();

        /// список элементов
        final items = <MediaItem>[];

        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(html);

        /// получаем элементы списка популярных
        final elements =
            document.getElementsByClassName('b-content__inline_item');

        for (final element in elements) {
          // <div class="b-content__inline_item" data-id="64013" data-url="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html">
          //   <div class="b-content__inline_item-cover"> <a href="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html"> <img src="http://static.rezka.cloud/i/2023/11/15/p608f1813f7e3yk66h87r.jpg" height="250" width="166" alt="Смотреть Новые уловки онлайн в HD качестве 720p" /> <span class="cat series"><i class="entity">Сериал</i><i class="icon"></i></span> <span class="info">Завершен (все серии)</span> <i class="i-sprt play"></i> </a> <i class="trailer show-trailer" data-id="64013" data-full="1"><b>Смотреть трейлер</b></i> </div>
          //   <div class="b-content__inline_item-link"> <a href="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html">Новые уловки</a>
          //     <div>2003-2015, Великобритания, Детективы</div>
          //   </div>
          // </div>

          /// парсим ссылку
          final id = element.attributes['data-id'] ?? '';
          final posterUrl = element
                  .getElementsByTagName('img')
                  .firstOrNull
                  ?.attributes['src'] ??
              '';
          final link = element
              .getElementsByClassName('b-content__inline_item-link')
              .first;

          /// парсим название
          final title = link.getElementsByTagName('a').first.text;

          items.add(RezkaItem(
            id: id,
            title: title,
            poster: posterUrl,
          ));
        }

        return items;
      },
    );
  }

  /// список популярных фильмов
  Future<List<MediaItem>> getPopularMovies() async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/films/page/1/?filter=popular'),
      decoder: (response) async {
        final html = response.toString();

        /// список элементов
        final items = <MediaItem>[];

        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(html);

        /// получаем элементы списка популярных
        final elements =
            document.getElementsByClassName('b-content__inline_item');

        for (final element in elements) {
          // <div class="b-content__inline_item" data-id="64013" data-url="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html">
          //   <div class="b-content__inline_item-cover"> <a href="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html"> <img src="http://static.rezka.cloud/i/2023/11/15/p608f1813f7e3yk66h87r.jpg" height="250" width="166" alt="Смотреть Новые уловки онлайн в HD качестве 720p" /> <span class="cat series"><i class="entity">Сериал</i><i class="icon"></i></span> <span class="info">Завершен (все серии)</span> <i class="i-sprt play"></i> </a> <i class="trailer show-trailer" data-id="64013" data-full="1"><b>Смотреть трейлер</b></i> </div>
          //   <div class="b-content__inline_item-link"> <a href="http://hdrezkayyh5pq.org/series/detective/64013-novye-ulovki-2003.html">Новые уловки</a>
          //     <div>2003-2015, Великобритания, Детективы</div>
          //   </div>
          // </div>

          /// парсим ссылку
          final id = element.attributes['data-id'] ?? '';
          final posterUrl = element
                  .getElementsByTagName('img')
                  .firstOrNull
                  ?.attributes['src'] ??
              '';
          final link = element
              .getElementsByClassName('b-content__inline_item-link')
              .first;

          /// парсим название
          final title = link.getElementsByTagName('a').first.text;

          items.add(RezkaItem(
            id: id,
            title: title,
            poster: posterUrl,
          ));
        }

        return items;
      },
    );
  }

  /// детали
  Future<RezkaItem> getDetails({
    required String id,
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<RezkaItem>().call(
      request: _dio.get('/$id-a.html'),
      decoder: (html) async {
        /// парсим html
        final document = parse(html);

        /// парсим озвучку
        final translatorsElements =
            document.getElementsByClassName('b-translator__item');

        /// парсим постер
        final posterUrl = document
                .getElementsByClassName('b-sidecover')
                .firstOrNull
                ?.getElementsByTagName('a')
                .firstOrNull
                ?.attributes['href'] ??
            '';

        /// парсим название фильма
        final movieName = document
                .getElementsByClassName('b-post__title')
                .firstOrNull
                ?.getElementsByTagName('h1')
                .firstOrNull
                ?.text ??
            '';

        /// парсим оригинальное название фильма
        final originalName = document
                .getElementsByClassName('b-post__origtitle')
                .firstOrNull
                ?.text ??
            '';

        /// парсим описание фильма
        final description = document
                .getElementsByClassName('b-post__description_text')
                .firstOrNull
                ?.text ??
            '';

        /// рейтинг IMDb
        double imdbRating = 0.0;

        /// рейтинг Kinopoisk
        double kinopoiskRating = 0.0;

        /// год выхода
        String year = '';

        /// страны
        List<String> countries = [];

        /// жанры
        List<String> genres = [];

        /// продолжительность
        Duration duration = Duration.zero;

        /// сезоны
        List<MediaItemSeason> seasons = [];

        final voiceActings = <VoiceActing>[];
        Map<String, List<MediaItemSeason>> voiceActingSeasons = {};

        /// парсим переводы
        final translatorsList = document
                .getElementById('translators-list')
                ?.getElementsByTagName('li')
                .map((e) {
              return VoiceActing(
                id: e.attributes['data-translator_id'] ?? '',
                name: e.text,
              );
            }).toList() ??
            [];
        final voiceActing = translatorsList.firstOrNull?.name ?? '';

        final postInfoTable = document
                .getElementsByClassName('b-post__info')
                .firstOrNull
                ?.getElementsByTagName('tr') ??
            [];

        for (final Element tr in postInfoTable) {
          final section = tr
                  .getElementsByClassName('l')
                  .firstOrNull
                  ?.getElementsByTagName('h2')
                  .firstOrNull
                  ?.text ??
              '';

          if (section == 'Рейтинги') {
            /// парсим рейтинг IMDb
            imdbRating = double.tryParse(tr
                        .getElementsByClassName('b-post__info_rates imdb')
                        .firstOrNull
                        ?.getElementsByClassName('bold')
                        .firstOrNull
                        ?.text ??
                    '0.0') ??
                0.0;

            /// парсим рейтинг Kinopoisk
            kinopoiskRating = double.tryParse(tr
                        .getElementsByClassName('b-post__info_rates kp')
                        .firstOrNull
                        ?.getElementsByClassName('bold')
                        .firstOrNull
                        ?.text ??
                    '0.0') ??
                0.0;
          } else if (section == 'Дата выхода') {
            /// парсим год выхода
            final yearHref = tr
                .getElementsByTagName('a')
                .firstOrNull
                ?.attributes['href']
                ?.split('/');
            yearHref?.removeLast();
            year = yearHref?.lastOrNull ?? '';
          } else if (section == 'Страна') {
            /// парсим страны
            countries =
                tr.getElementsByTagName('a').map((e) => e.text).toList();
          } else if (section == 'Жанр') {
            /// парсим жанры
            genres =
                tr.getElementsByTagName('span').map((e) => e.text).toList();
          } else if (section == 'Время') {
            /// парсим продолжительность
            final durationMinutes = int.tryParse(tr
                        .getElementsByTagName('td')
                        .lastOrNull
                        ?.text
                        .split(' ')
                        .firstOrNull ??
                    '0') ??
                0;
            duration = Duration(minutes: durationMinutes);
          }
        }

        // voiceActings[movie.translation] = VoiceActing(
        //   id: movie.translation,
        //   name: movie.translation,
        //   seasons: [
        //     SeasonItem(
        //       episodes: [
        //         EpisodeItem(
        //           id: '0/0',
        //           fullId: EpisodeItem.getFullId(provider.name, id.toString(), '0/0'),
        //           playableQualities: playableQualities,
        //           videoFileUrl: videoUrl,
        //           duration: duration,
        //         ),
        //       ],
        //     )
        //   ],
        // );

        final movieId = document
                .getElementById('send-video-issue')
                ?.attributes['data-id'] ??
            '';

        return RezkaItem(
          id: movieId,
          title: movieName,
          poster: posterUrl,
          overview: description.trim(),
          seasons: [
            MediaItemSeason(
              episodes: [
                MediaItemEpisode(
                  id: '',
                ),
              ],
            ),
          ],

          originalTitle: originalName,
          year: year.toString(),
          countries: countries,
          genres: genres,
          imdbRating: imdbRating,
          kinopoiskRating: kinopoiskRating,
          // duration: duration,
          // voiceActings: {for (final v in translatorsList) v.name: v},
          // voiceActing: voiceActing,
        );
      },
    );
  }

  // /// список популярных
  // Future<List<MediaItem>> getPopularShows() async {
  //   return ApiRequest<List<MediaItem>>().call(
  //     request: _dio.get('/'),
  //     decoder: (response) async {
  //       final html = response.toString();

  //       /// список элементов
  //       final items = <MediaItem>[];

  //       /// ^ если запрос выполнен успешно
  //       /// парсим html
  //       final document = parse(html);

  //       /// получаем элементы списка популярных
  //       final elements = document
  //               .getElementById('index-top-tab')
  //               ?.getElementsByClassName('app-shows-item-full') ??
  //           [];

  //       for (final element in elements) {
  //         // <div class="show">
  //         //   <a href="/show/wednesday_rezka">
  //         //     <img src="/posters/wednesday_rezka.png" srcset="/posters2/wednesday_rezka.png 2x" alt="Уэнздей (Уэнсдей)" class="poster poster-lazy" data-toggle="tooltip" data-placement="top" title="Зарубежные сериалы, Комедия">
  //         //     <p class="show-title"><img class="app-shows-show-flag" src="https://www.ts.kg/img/flags/svg/4x3/us.svg" alt="США">Уэнздей (Уэнсдей)</p>
  //         //   </a>
  //         // </div>

  //         /// парсим ссылку
  //         final link = element.getElementsByTagName('a').first;
  //         final src = link.attributes['href'] ?? '';
  //         final id = TskgItem.getShowIdFromUrl(src);

  //         /// парсим название
  //         final title =
  //             element.getElementsByClassName('app-shows-card-title').first.text;

  //         items.add(TskgItem(
  //           id: id,
  //           title: title,
  //         ));
  //       }

  //       return items;
  //     },
  //   );
  // }

  // /// получение информации о сериале
  // Future<MediaItem> getDetails({
  //   required String showId,
  //   CancelToken? cancelToken,
  // }) async {
  //   return ApiRequest<MediaItem>().call(
  //     request: _dio.get(getShowUrlById(showId), cancelToken: cancelToken),
  //     decoder: (response) async {
  //       final html = response.toString();

  //       return await compute(parseDetails, html);
  //     },
  //   );
  // }

  // /// получение информации об эпизоде
  // Future<MediaItemUrl> getEpisodePlayableUrl(String episodeId) async {
  //   try {
  //     /// запрашиваем данные
  //     final response = await _dio.get(
  //       '/show/episode/episode.json',
  //       queryParameters: {
  //         'episode': episodeId,
  //       },
  //       options: Options(
  //         headers: {
  //           'x-requested-with': 'XMLHttpRequest',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       /// ^ если запрос выполнен успешно

  //       /// возвращаем информацио об эпизоде
  //       return MediaItemUrl(
  //         video: response.data['video']['url'],
  //         subtitles: response.data['video']['subtitles'] ?? '',
  //       );
  //     }
  //   } catch (exception) {
  //     /// ^ если прозошла сетевая ошибка

  //     debugPrint('exception: $exception');
  //   }

  //   return MediaItemUrl();
  // }

  // /// поиск сериала
  // Future<List<MediaItem>> search({
  //   required String searchQuery,
  //   CancelToken? cancelToken,
  // }) async {
  //   return ApiRequest<List<MediaItem>>().call(
  //     request: _dio.get(
  //       '/shows/search/$searchQuery',
  //       cancelToken: cancelToken,
  //       options: Options(
  //         headers: {
  //           'x-requested-with': 'XMLHttpRequest',
  //         },
  //       ),
  //     ),
  //     decoder: (response) async {
  //       final items = <MediaItem>[];

  //       for (final item in response) {
  //         final name = item['name'];
  //         final url = item['url'];

  //         if (url.startsWith('/show/')) {
  //           final showId = TskgItem.getShowIdFromUrl(url);
  //           items.add(TskgItem(
  //             id: showId,
  //             title: name,
  //           ));
  //         }
  //       }

  //       return items;
  //     },
  //   );
  // }

  static const String rezkaSeparator = '//_//';
  static const List<String> rezkaBlocks = [
    'JCQhIUAkJEBeIUAjJCRA',
    'QEBAQEAhIyMhXl5e',
    'IyMjI14hISMjIUBA',
    'Xl5eIUAjIyEhIyM=',
    'JCQjISFAIyFAIyM='
  ];

  List<RezkaQuality> parseStreams(String salted) {
    salted = salted.replaceAll('\\', '');

    for (String bk in rezkaBlocks) {
      salted = salted.replaceAll(rezkaSeparator + bk, '');
    }

    final decodedStreams = utf8.decode(base64.decode(salted.substring(2)));

    List<RezkaQuality> parsedStreams = [];
    RegExp exp =
        RegExp(r'\[((\d+)([a-z ]+))].+?(http.+?mp4)', caseSensitive: false);
    final matches = exp.allMatches(decodedStreams);
    for (Match match in matches) {
      if (match.groupCount == 4 &&
          match.group(1) != null &&
          match.group(4) != null) {
        parsedStreams.add(RezkaQuality(
          quality: match.group(1)!,
          url: match.group(4)!,
        ));
      }
    }
    return parsedStreams;

    ///:hls:manifest.m3u8
  }
}

class RezkaQuality {
  final String quality;
  final String url;

  RezkaQuality({required this.quality, required this.url});
}
