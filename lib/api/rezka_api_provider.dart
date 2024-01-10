import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_request.dart';
import '../models/media_item.dart';
import '../models/rezka/rezka_item.dart';
import '../providers/providers.dart';
import 'interceptors/logs_interceptor.dart';

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

  String parseUrlId(String? url) {
    return (url ?? '').split('/').last.split('.').first;
  }

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
          final id = parseUrlId(element.attributes['data-url']);
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
          final id = parseUrlId(element.attributes['data-url']);
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
          final id = parseUrlId(element.attributes['data-url']);
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
      request: _dio.get('/$id.html'),
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

        Map<String, List<MediaItemSeason>> voiceActingSeasons = {};

        /// парсим переводы
        final voices = document
                .getElementById('translators-list')
                ?.getElementsByTagName('li')
                .map((e) {
              return VoiceActing(
                id: e.attributes['data-translator_id'] ?? '',
                name: e.text,
              );
            }).toList() ??
            [];
        final voiceActing = voices.firstOrNull ?? const VoiceActing();

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

        final movieId = document
                .getElementById('send-video-issue')
                ?.attributes['data-id'] ??
            '';

        /// количество сезонов
        final seasonsCount =
            document.getElementsByClassName('b-simple_season__item').length;

        /// если нет элемента эпизодов, то это фильм
        final isMovie = document.getElementById('simple-episodes-tabs') == null;

        if (isMovie) {
          final exp = RegExp(r'"streams":"([^"]+)');
          final stream =
              exp.allMatches(document.body!.text).firstOrNull?.group(1) ?? '';
          final qualities = parseStreams(stream);
          seasons = [
            MediaItemSeason(
              episodes: [
                MediaItemEpisode(
                  id: '',
                  qualities: qualities.map((q) => q.quality).toList(),
                ),
              ],
            ),
          ];
        }

        return RezkaItem(
          type: isMovie ? MediaItemType.movie : MediaItemType.show,
          id: movieId,
          title: movieName,
          poster: posterUrl,
          overview: description.trim(),
          seasons: seasons,

          seasonCount: seasonsCount,

          originalTitle: originalName,
          year: year.toString(),
          countries: countries,
          genres: genres,
          imdbRating: imdbRating,
          kinopoiskRating: kinopoiskRating,
          // duration: duration,

          voices: voices,
          voiceActing: voiceActing,
        );
      },
    );
  }

  // /// извлекаем список сезонов
  // Future<List<MediaItemSeason>> getSeasons({
  //   required String id,
  //   CancelToken? cancelToken,
  // }) async {
  //   return ApiRequest<List<MediaItemSeason>>().call(
  //     request: _dio.get('/$id.html'),
  //     decoder: (html) async {
  //       /// парсим html
  //       final document = parse(html);
  //
  //       /// сезоны
  //       List<MediaItemSeason> seasons = [];
  //
  //       /// парсим переводы
  //       final translatorsList = document
  //               .getElementById('translators-list')
  //               ?.getElementsByTagName('li')
  //               .map((e) {
  //             return VoiceActing(
  //               id: e.attributes['data-translator_id'] ?? '',
  //               name: e.text,
  //             );
  //           }).toList() ??
  //           [];
  //       final voiceActing = translatorsList.firstOrNull?.name ?? '';
  //
  //       final postInfoTable = document
  //               .getElementsByClassName('b-post__info')
  //               .firstOrNull
  //               ?.getElementsByTagName('tr') ??
  //           [];
  //
  //       for (final Element tr in postInfoTable) {
  //         final section = tr
  //                 .getElementsByClassName('l')
  //                 .firstOrNull
  //                 ?.getElementsByTagName('h2')
  //                 .firstOrNull
  //                 ?.text ??
  //             '';
  //
  //         if (section == 'Рейтинги') {
  //           /// парсим рейтинг IMDb
  //           imdbRating = double.tryParse(tr
  //                       .getElementsByClassName('b-post__info_rates imdb')
  //                       .firstOrNull
  //                       ?.getElementsByClassName('bold')
  //                       .firstOrNull
  //                       ?.text ??
  //                   '0.0') ??
  //               0.0;
  //
  //           /// парсим рейтинг Kinopoisk
  //           kinopoiskRating = double.tryParse(tr
  //                       .getElementsByClassName('b-post__info_rates kp')
  //                       .firstOrNull
  //                       ?.getElementsByClassName('bold')
  //                       .firstOrNull
  //                       ?.text ??
  //                   '0.0') ??
  //               0.0;
  //         } else if (section == 'Дата выхода') {
  //           /// парсим год выхода
  //           final yearHref = tr
  //               .getElementsByTagName('a')
  //               .firstOrNull
  //               ?.attributes['href']
  //               ?.split('/');
  //           yearHref?.removeLast();
  //           year = yearHref?.lastOrNull ?? '';
  //         } else if (section == 'Страна') {
  //           /// парсим страны
  //           countries =
  //               tr.getElementsByTagName('a').map((e) => e.text).toList();
  //         } else if (section == 'Жанр') {
  //           /// парсим жанры
  //           genres =
  //               tr.getElementsByTagName('span').map((e) => e.text).toList();
  //         } else if (section == 'Время') {
  //           /// парсим продолжительность
  //           final durationMinutes = int.tryParse(tr
  //                       .getElementsByTagName('td')
  //                       .lastOrNull
  //                       ?.text
  //                       .split(' ')
  //                       .firstOrNull ??
  //                   '0') ??
  //               0;
  //           duration = Duration(minutes: durationMinutes);
  //         }
  //       }
  //
  //       // voiceActings[movie.translation] = VoiceActing(
  //       //   id: movie.translation,
  //       //   name: movie.translation,
  //       //   seasons: [
  //       //     SeasonItem(
  //       //       episodes: [
  //       //         EpisodeItem(
  //       //           id: '0/0',
  //       //           fullId: EpisodeItem.getFullId(provider.name, id.toString(), '0/0'),
  //       //           playableQualities: playableQualities,
  //       //           videoFileUrl: videoUrl,
  //       //           duration: duration,
  //       //         ),
  //       //       ],
  //       //     )
  //       //   ],
  //       // );
  //
  //       final movieId = document
  //               .getElementById('send-video-issue')
  //               ?.attributes['data-id'] ??
  //           '';
  //
  //       /// количество сезонов
  //       final seasonsCount =
  //           document.getElementsByClassName('b-simple_season__item').length;
  //
  //       /// если нет элемента эпизодов, то это фильм
  //       final isMovie = document.getElementById('simple-episodes-tabs') == null;
  //
  //       if (isMovie) {
  //         final exp = RegExp(r'"streams":"([^"]+)');
  //         final stream =
  //             exp.allMatches(document.body!.text).firstOrNull?.group(1) ?? '';
  //         final qualities = parseStreams(stream);
  //         seasons = [
  //           MediaItemSeason(
  //             episodes: [
  //               MediaItemEpisode(
  //                 id: '',
  //                 qualities: qualities.map((q) => q.quality).toList(),
  //               ),
  //             ],
  //           ),
  //         ];
  //       }
  //
  //       return RezkaItem(
  //         type: isMovie ? MediaItemType.movie : MediaItemType.show,
  //         id: movieId,
  //         title: movieName,
  //         poster: posterUrl,
  //         overview: description.trim(),
  //         seasons: seasons,
  //
  //         seasonCount: seasonsCount,
  //
  //         originalTitle: originalName,
  //         year: year.toString(),
  //         countries: countries,
  //         genres: genres,
  //         imdbRating: imdbRating,
  //         kinopoiskRating: kinopoiskRating,
  //         // duration: duration,
  //         // voiceActings: {for (final v in translatorsList) v.name: v},
  //         // voiceActing: voiceActing,
  //       );
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
