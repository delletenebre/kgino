import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_request.dart';
import '../models/media_item.dart';
import '../models/media_item_url.dart';
import '../models/rezka/rezka_item.dart';
import '../providers/providers.dart';

part 'rezka_api_provider.g.dart';

@Riverpod(keepAlive: true)
RezkaApi rezkaApi(RezkaApiRef ref) => RezkaApi(ref);

class RezkaApi {
  final RezkaApiRef ref;

  CancelToken getCancelToken() => CancelToken();

  static const userAgent =
      'Mozilla/5.0 (Windows NT 6.2; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0';

  final _dio = Dio(BaseOptions(
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      // 'User-Agent': userAgent,
    },
  ));

  RezkaApi(this.ref) {
    /// добавляем перехватчик, для логов запросов
    // _dio.interceptors.add(LogsInterceptor());

    /// хранилище данных
    final storage = ref.read(storageProvider);

    String baseUrl =
        storage.sharedStorage.getString('rezka_url') ?? 'https://rezka.ag';

    _dio.options.baseUrl = baseUrl;
  }

  String parseUrlId(String? url) {
    return (url ?? '').split('/').last.split('.').first;
  }

  /// список сериалов
  Future<List<MediaItem>> _getShows(String filter) async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/series/page/1/?filter=$filter'),
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

  /// список новых сериалов
  Future<List<MediaItem>> getLatestShows() => _getShows('last');

  /// список популярных сериалов
  Future<List<MediaItem>> getPopularShows() => _getShows('popular');

  /// список фильмов
  Future<List<MediaItem>> _getMovies(String filter) async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/films/page/1/?filter=$filter'),
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
  Future<List<MediaItem>> getLatestMovies() => _getMovies('last');

  /// список популярных фильмов
  Future<List<MediaItem>> getPopularMovies() => _getMovies('popular');

  /// детали
  Future<RezkaItem> getDetails({
    required String isarId,
    required String id,
    required VoiceActing voiceActing,
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

        VoiceActing actualVoiceActing = voiceActing;

        if (actualVoiceActing.id.isEmpty) {
          /// ^ если озвучка не выбрана

          if (voices.isNotEmpty) {
            /// ^ если список озвучек присутствует

            /// берём первую из списка
            actualVoiceActing = voices.first;
          } else {
            /// ^ если списка озвучек нет

            /// необходимо найти идентификатор озвучки
            final exp = RegExp(r'initCDNSeriesEvents\((\d+, \d+)',
                caseSensitive: false);
            final translatorId = exp
                    .allMatches(document.body!.text)
                    .firstOrNull
                    ?.group(1)
                    ?.split(', ')
                    .lastOrNull ??
                '';
            actualVoiceActing = VoiceActing(id: translatorId);
          }
        }

        /// информация о сериале или фильме
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

        Element? tvShow = document.getElementById('simple-episodes-tabs');

        /// если нет элемента эпизодов, то это фильм
        final isMovie = (tvShow == null);

        /// извлекаем ссылки на видео-поток
        final exp = RegExp(r'"streams":"([^"]+)');
        final streams = parseStreams(
            exp.allMatches(document.body!.text).firstOrNull?.group(1) ?? '');

        /// список качества видео
        final qualities = streams.map((q) => q.quality).toList();

        if (isMovie) {
          final episodes = streams
              .map(
                (stream) => MediaItemEpisode(
                  id: '$isarId@0|0',
                  name: stream.quality,
                  videoFileUrl: stream.url,
                  qualities: qualities,
                ),
              )
              .toList();

          seasons = [
            MediaItemSeason(
              episodes: episodes,
            ),
          ];
        } else {
          /// ^ если это сериал

          final postId =
              document.getElementById('post_id')!.attributes['value'] ?? '';

          tvShow = await getSeasons(
                id: postId,
                voiceActingId: actualVoiceActing.id,
              ) ??
              tvShow;

          final episodesLi = tvShow.getElementsByTagName('li');

          final episodes = episodesLi.map((episode) {
            final seasonId =
                int.parse(episode.attributes['data-season_id'] ?? '0');
            final episodeId =
                int.parse(episode.attributes['data-episode_id'] ?? '0');
            return MediaItemEpisode(
              id: '$isarId@$seasonId|$episodeId',
              name: 'Эпизод $episodeId',
              seasonNumber: seasonId,
              episodeNumber: episodeId,
              qualities: qualities,
            );
          });

          seasons = episodesLi
              .map((episode) {
                return int.parse(episode.attributes['data-season_id'] ?? '0');
              })
              .toSet()
              .map((seasonNumber) => MediaItemSeason(
                    name: 'Сезон $seasonNumber',
                    episodes: episodes
                        .where(
                            (episode) => episode.seasonNumber == seasonNumber)
                        .toList(),
                  ))
              .toList();
        }

        return RezkaItem(
          type: isMovie ? MediaItemType.movie : MediaItemType.show,
          id: id,
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
          voiceActing: actualVoiceActing,
        );
      },
    );
  }

  /// детали
  Future<String> getCdnSeries({
    required String id,
    required String url,
    required String action,
    required String voiceActingId,
    CancelToken? cancelToken,
  }) async {
    final headers = {
      // 'Host': 'hdrezka.ag',
      // 'Origin': 'https://hdrezka.ag',
      // 'Referer': '/series/comedy/63418-lyubov-na-shesteryh-2000.html',
      // 'User-Agent':
      //     'Mozilla/5.0 (Windows NT 6.2; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0',
      // 'X-Requested-With': 'XMLHttpRequest',
      //'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
    };

    //final data = {'id': id, 'translator_id': voiceActingId, 'action': action};
    final data = {
      'id': '63418',
      'translator_id': '59',
      'action': 'get_episodes'
    };

    return ApiRequest<String>().call(
      request: _dio.post(
        '/ajax/get_cdn_series/',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      ),
      decoder: (html) async {
        print('html: $html');
        return '';
      },
    );
  }

  /// список сезонов и эпизодов
  Future<Element?> getSeasons({
    required String id,
    required String voiceActingId,
    CancelToken? cancelToken,
  }) async {
    final headers = {
      // 'Host': 'hdrezka.ag',
      // 'Origin': 'https://hdrezka.ag',
      // 'Referer': '/series/comedy/63418-lyubov-na-shesteryh-2000.html',
      // 'User-Agent':
      //     'Mozilla/5.0 (Windows NT 6.2; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0',
      // 'X-Requested-With': 'XMLHttpRequest',
      //'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
    };

    final data = {
      'id': id,
      'translator_id': voiceActingId,
      'action': 'get_episodes'
    };

    return ApiRequest<Element?>().call(
      request: _dio.post(
        '/ajax/get_cdn_series/',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      ),
      decoder: (response) async {
        final json = jsonDecode(response);
        final html = json['episodes'];
        debugPrint('getSeasons: $json');

        if (html != null) {
          return parse(html).documentElement;
        }

        return null;
      },
    );
  }

  /// ссылка на проигрываемый файл
  Future<MediaItemUrl> getStream({
    required String id,
    required String voiceActingId,
    required int seasonId,
    required int episodeId,
    required String quality,
    CancelToken? cancelToken,
  }) async {
    final data = {
      'id': id,
      'translator_id': voiceActingId,
      'season': seasonId,
      'episode': episodeId,
      'action': 'get_stream',
    };

    return ApiRequest<MediaItemUrl>().call(
      request: _dio.post(
        '/ajax/get_cdn_series/',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      ),
      decoder: (response) async {
        final json = jsonDecode(response);
        final stream = parseStreams(json['url']);

        return MediaItemUrl(
          video: stream
                  .singleWhereOrNull((element) => element.quality == quality)
                  ?.url ??
              stream.first.url,
        );
      },
    );
  }

  /// ссылка на проигрываемый файл фильма
  Future<MediaItemUrl> getMovieStream({
    required String id,
    required String voiceActingId,
    required String quality,
    CancelToken? cancelToken,
  }) async {
    final data = {
      'id': id,
      'translator_id': voiceActingId,
      'action': 'get_movie',
    };

    return ApiRequest<MediaItemUrl>().call(
      request: _dio.post(
        '/ajax/get_cdn_series/',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      ),
      decoder: (response) async {
        final json = jsonDecode(response);
        debugPrint(json.toString());
        final stream = parseStreams(json['url']);

        debugPrint(json);

        return MediaItemUrl(
          video: stream
                  .singleWhereOrNull((element) => element.quality == quality)
                  ?.url ??
              stream.first.url,
        );
      },
    );
  }

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

  @override
  String toString() {
    return '{quality: $quality, url: $url}';
  }
}
