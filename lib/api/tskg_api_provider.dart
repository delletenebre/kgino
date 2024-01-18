import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_request.dart';
import '../models/media_item.dart';
import '../models/media_item_url.dart';
import '../models/tskg/tskg_item.dart';
import 'tskg_isolates.dart';

part 'tskg_api_provider.g.dart';

@Riverpod(keepAlive: true)
TskgApi tskgApi(TskgApiRef ref) => TskgApi(ref);

class TskgApi {
  final TskgApiRef ref;

  CancelToken getCancelToken() => CancelToken();

  static final userAgent =
      'KGino/${kIsWeb ? 'Web' : Platform.operatingSystem} ${kIsWeb ? 'Web' : Platform.operatingSystemVersion}';

  static const baseUrl = kIsWeb
      //? 'https://app.iuk.edu.kg/functions/v1/corsproxy?url=https://www.ts.kg'
      ? 'https://app.iuk.edu.kg/functions/v1/proxy/?url=https://www.ts.kg'
      : 'https://www.ts.kg';

  final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'User-Agent': userAgent,
    },
  ));

  TskgApi(this.ref) {
    /// добавляем перехватчик, для логов запросов
    //_dio.interceptors.add(LogsInterceptor());
  }

  /// формируем полную ссылку на постер сериала по id
  String getPosterUrlById(String showId) {
    return '${_dio.options.baseUrl}/posters/$showId.png';
  }

  /// формируем полную ссылку на сериал по id
  String getShowUrlById(String showId) {
    return '${_dio.options.baseUrl}/show/$showId';
  }

  static String getTextByClassName(Document document, String className) {
    final elements = document.getElementsByClassName(className);
    if (elements.isNotEmpty) {
      return elements.first.text.trim();
    }

    return '';
  }

  /// список последних поступлений
  Future<List<MediaItem>> getLastEpisodes() async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/news'),
      decoder: (response) async {
        final html = response.toString();

        final items = <MediaItem>[];

        /// парсим html
        final document = parse(html);

        /// получаем элементы списка новых поступлений
        final elements = document.getElementsByClassName('app-news-block');

        for (final element in elements) {
          /// парсим дату добавления
          /// <div class="app-news-date"><strong>22.12.2021</strong></div>
          final dateText =
              element.getElementsByClassName('app-news-date').first.text;
          final date = DateFormat('dd.MM.yyyy').parse(dateText);

          /// парсим элементы новых поступлений
          /*
            <div class="app-news-list-item">
                <div class="clearfix news">
                  <i class="fas fa-caret-right"></i>
                <span class="label label-default"><span class="fas fa-sync-alt" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Обновлено"></span></span>
                <a class="news-link app-news-link" href="/show/zhenskii_stand_up/3/16" data-toggle="tooltip" data-placement="top" title="ТВ-шоу (российские), Стендап, Юмористическое шоу">Женский стендап</a>
                <span class="text-muted clearfix"><small>3 сезон, 16 серия</small></span>
              </div>
            </div>
          */
          final listItems =
              element.getElementsByClassName('app-news-list-item');
          for (final listItem in listItems) {
            //debugPrint('date: $DateFormat');

            final tagsA = listItem.getElementsByClassName('app-news-link');
            if (tagsA.isNotEmpty) {
              /// ^ если в новостях найден элемент <a></a>

              final tagA = tagsA.first;

              final tagSmall = listItem.getElementsByTagName('small');

              /// ссылка на сериал/подборку/серию
              final link = tagA.attributes['href'] ?? '';
              //debugPrint('link: $link');

              /// название сериала или подборки
              final title = tagA.text;
              //debugPrint('title: $title');

              /// дополнительная информация (например, сезон и номер серии)
              String subtitle = '';
              if (tagSmall.isNotEmpty) {
                subtitle = tagSmall.first.text;
              }

              /// жанры
              final genres = (tagA.attributes['title'] ?? '').split(', ');
              // debugPrint('genres: $genres');

              // /// значки (badges)
              // final badges = listItem.getElementsByClassName('label').map((badge) {

              //   if (badge.text.isEmpty) {
              //     /// ^ если значок в виде иконки
              //     return badge.firstChild?.attributes['title'] ?? '';

              //   } else {
              //     /// ^ если значок подписан

              //     return badge.text;

              //   }

              // });

              final id = TskgItem.getShowIdFromUrl(link);
              if (id.isNotEmpty) {
                items.add(TskgItem(
                  id: id,
                  title: title,
                  //subtitle: subtitle,
                  genres: genres,
                ));
              }
            }
          }
        }

        return items;
      },
    );
  }

  /// список новых
  Future<List<MediaItem>> getLatestShows() async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/'),
      decoder: (response) async {
        final html = response.toString();

        /// список элементов
        final items = <MediaItem>[];

        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(html);

        /// получаем элементы списка популярных
        final elements = document
                .getElementById('index-news-poster-tab')
                ?.getElementsByClassName('app-shows-item-full') ??
            [];

        for (final element in elements) {
          // <div class="show">
          //   <a href="/show/wednesday_rezka">
          //     <img src="/posters/wednesday_rezka.png" srcset="/posters2/wednesday_rezka.png 2x" alt="Уэнздей (Уэнсдей)" class="poster poster-lazy" data-toggle="tooltip" data-placement="top" title="Зарубежные сериалы, Комедия">
          //     <p class="show-title"><img class="app-shows-show-flag" src="https://www.ts.kg/img/flags/svg/4x3/us.svg" alt="США">Уэнздей (Уэнсдей)</p>
          //   </a>
          // </div>

          /// парсим ссылку
          final link = element.getElementsByTagName('a').first;
          final src = link.attributes['href'] ?? '';
          final id = TskgItem.getShowIdFromUrl(src);

          /// парсим название
          final title =
              element.getElementsByClassName('app-shows-card-title').first.text;

          items.add(TskgItem(
            id: id,
            title: title,
          ));
        }

        return items;
      },
    );
  }

  /// список популярных
  Future<List<MediaItem>> getPopularShows() async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/'),
      decoder: (response) async {
        final html = response.toString();

        /// список элементов
        final items = <MediaItem>[];

        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(html);

        /// получаем элементы списка популярных
        final elements = document
                .getElementById('index-top-tab')
                ?.getElementsByClassName('app-shows-item-full') ??
            [];

        for (final element in elements) {
          // <div class="show">
          //   <a href="/show/wednesday_rezka">
          //     <img src="/posters/wednesday_rezka.png" srcset="/posters2/wednesday_rezka.png 2x" alt="Уэнздей (Уэнсдей)" class="poster poster-lazy" data-toggle="tooltip" data-placement="top" title="Зарубежные сериалы, Комедия">
          //     <p class="show-title"><img class="app-shows-show-flag" src="https://www.ts.kg/img/flags/svg/4x3/us.svg" alt="США">Уэнздей (Уэнсдей)</p>
          //   </a>
          // </div>

          /// парсим ссылку
          final link = element.getElementsByTagName('a').first;
          final src = link.attributes['href'] ?? '';
          final id = TskgItem.getShowIdFromUrl(src);

          /// парсим название
          final title =
              element.getElementsByClassName('app-shows-card-title').first.text;

          items.add(TskgItem(
            id: id,
            title: title,
          ));
        }

        return items;
      },
    );
  }

  /// получение информации о сериале
  Future<TskgItem> getDetails({
    required String showId,
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<TskgItem>().call(
      request: _dio.get(getShowUrlById(showId), cancelToken: cancelToken),
      decoder: (response) async {
        final html = response.toString();

        return await compute(parseDetails, html);
      },
    );
  }

  /// получение списка эпизодов
  Future<List<MediaItemSeason>> getSeasons({
    required String showId,
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<List<MediaItemSeason>>().call(
      request: _dio.get(getShowUrlById(showId), cancelToken: cancelToken),
      decoder: (response) async {
        final html = response.toString();

        return await compute(parseSeasons, html);
      },
    );
  }

  /// получение информации об эпизоде
  Future<MediaItemUrl> getEpisodePlayableUrl(String episodeId) async {
    try {
      /// запрашиваем данные
      final response = await _dio.get(
        '/show/episode/episode.json?episode=$episodeId',
        // queryParameters: {
        //   'episode': episodeId,
        // },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно

        /// возвращаем информацию об эпизоде
        return MediaItemUrl(
          video: response.data['video']['url'],
          subtitles: response.data['video']['subtitles'] ?? '',
        );
      }
    } catch (exception) {
      /// ^ если произошла сетевая ошибка

      debugPrint('exception: $exception');
    }

    return MediaItemUrl();
  }

  /// поиск сериала
  Future<List<MediaItem>> search({
    required String searchQuery,
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get(
        '/shows/search/$searchQuery',
        cancelToken: cancelToken,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      ),
      decoder: (response) async {
        final items = <MediaItem>[];

        for (final item in response) {
          final name = item['name'];
          final url = item['url'];

          if (url.startsWith('/show/')) {
            final showId = TskgItem.getShowIdFromUrl(url);
            items.add(TskgItem(
              id: showId,
              title: name,
            ));
          }
        }

        return items;
      },
    );
  }
}
