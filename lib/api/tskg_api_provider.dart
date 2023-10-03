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
import '../models/tskg/tskg_item.dart';
import '../models/voice_acting.dart';
import 'interceptors/logs_interceptor.dart';
import 'models/api_request.dart';

part 'tskg_api_provider.g.dart';

@Riverpod(keepAlive: true)
TskgApi tskgApi(TskgApiRef ref) => TskgApi(ref);

class TskgApi {
  final TskgApiRef ref;

  CancelToken getCancelToken() => CancelToken();

  static final userAgent =
      'KGino/${kIsWeb ? 'Web' : Platform.operatingSystem} ${kIsWeb ? 'Web' : Platform.operatingSystemVersion}';

  final _dio = Dio(BaseOptions(
    baseUrl: 'https://www.ts.kg',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'User-Agent': userAgent,
    },
  ));

  TskgApi(this.ref) {
    /// добавляем перехватчик, для логов запросов
    _dio.interceptors.add(LogsInterceptor());
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
      decoder: (response) {
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
      decoder: (response) {
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
      decoder: (response) {
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
  Future<MediaItem> getShowDetails(
    String showId, {
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<MediaItem>().call(
      request: _dio.get(getShowUrlById(showId), cancelToken: cancelToken),
      decoder: (response) {
        final html = response.toString();

        /// парсим html
        final document = parse(html);

        /// парсим идентификатор сериала
        final showIdUrl = document
            .getElementsByClassName('episode')
            .firstOrNull
            ?.attributes['href'];
        final showId = TskgItem.getShowIdFromUrl(showIdUrl ?? '');

        /// парсим название сериала
        final title = document.getElementById('h-show-title')?.text ?? '';

        /// парсим название на языке оригинала
        final originalTitle =
            getTextByClassName(document, 'app-show-header-title-original');

        /// парсим года выпуска сериала
        /// убираем 'завершён/закрыт' из '2001-2010, завершён/закрыт'
        final years = getTextByClassName(document, 'app-show-header-years')
            .split(', ')
            .first;

        /// парсим страны, жанры
        final tags = document
            .getElementsByClassName('app-show-tags')
            .last
            .getElementsByTagName('a');

        final genres = tags
            .where((element) {
              /// получаем атрибут href
              final href = element.attributes['href'] ?? '';

              /// находим только те элементы, которые указывают жанр сериала
              // return href.startsWith('/category') || href.startsWith('/genre');
              return href.startsWith('/genre');
            })
            .map((element) => element.text)
            .toList();
        // debugPrint('show genres: $genres');

        /// формируем список стран
        final countries = document
            .getElementsByClassName('app-show-tags-flag')
            // tags.where((element) {
            //   /// получаем атрибут href
            //   final href = element.attributes['href'] ?? '';
            //   /// находим только те элементы, которые указывают на страну
            //   return href.startsWith('/show?country');
            // })
            .map((element) {
          /// получаем название страны
          final countryName = element.attributes['title'] ?? '';

          /// получаем атрибут стиля элемента (изображение как background-image)
          // String countryImageUrl = element.attributes['style'] ?? '';
          // if (countryImageUrl.startsWith('background-image: url(')) {
          //   /// ^ если ссылка на изображение страны не пустая

          //   /// вырезаем [background-image: url(https://www.ts.kg/img/flags/svg/4x3/ru.svg)]
          //   countryImageUrl = countryImageUrl
          //     .substring(22, countryImageUrl.length - 1);
          // }

          if (countryName == 'Российская Федерация') {
            return 'Россия';
          }

          return countryName;
          // return TskgCountry(
          //   name: countryName,
          //   imageUrl: countryImageUrl,
          // );
        }).toList();

        /// парсим описание сериала
        final description =
            getTextByClassName(document, 'app-show-description');

        /// парсим список сезонов
        final seasonElements =
            document.getElementsByClassName('app-show-seasons-section-full');

        /// формируем сезоны сериала
        final seasons = seasonElements.mapIndexed((seasonIndex, season) {
          /// парсим заголовок названия сезона
          final seasonTitleTable = season
              .getElementsByClassName('app-show-season-title-table')
              .first;

          /// получаем название сезона
          final seasonTitle =
              seasonTitleTable.getElementsByTagName('a').first.text;

          /// парсим список эпизодов сезона
          final seasonEpisodesTable =
              season.getElementsByClassName('app-show-season-collapse').first;
          final seasonEpisodeRows =
              seasonEpisodesTable.getElementsByTagName('tr');

          /// формируем эпизоды сезона
          final episodes =
              seasonEpisodeRows.mapIndexed((episodeIndex, episodeRow) {
            /// парсим качество записи SD|HD
            //final episodeQuality = episodeRow.getElementsByClassName('btn btn-default btn-xs').first.text;

            /// парсим название и id эпизода
            final episodeTitleElement =
                episodeRow.getElementsByClassName('text-primary').first;
            String episodeTitle = episodeTitleElement.text;

            final regExp = RegExp(r'^\d+?\: (.+?)$');

            if (regExp.hasMatch(episodeTitle)) {
              episodeTitle = regExp.firstMatch(episodeTitle)?.group(1) ?? '';
            }

            // final episodeUrl = episodeTitleElement.attributes['href'] ?? '';
            final episodeIdAttribute =
                episodeTitleElement.attributes['id'] ?? '-';
            final episodeId =
                int.tryParse(episodeIdAttribute.split('-').last) ?? 0;

            /// парсим продолжительность эпизода
            final episodeDurationString =
                episodeTitleElement.nextElementSibling?.text.trim() ?? '';
            Duration episodeDuration = Duration.zero;
            if (episodeDurationString.isNotEmpty) {
              /// ^ если указана продолжительность эпизода

              episodeDuration = episodeDurationString.substring(2).toDuration();
            }

            /// парсим описание эпизода (перевод, обычно)
            // final episodeDescription = episodeRow.getElementsByClassName('text-muted clearfix').first.text.trim().replaceAll('⠀', '');

            return MediaItemEpisode(
              id: '${OnlineService.tskg.name}|$showId@$episodeId',
              // fullId: EpisodeItem.getFullId(KginoProvider.tskg.name, showId, '$episodeId'),
              name: episodeTitle,
              seasonNumber: seasonIndex + 1,
              episodeNumber: episodeIndex + 1,
              duration: episodeDuration.inSeconds,
              // quality: episodeQuality,
            );
          }).toList();

          return MediaItemSeason(
            name: seasonTitle,
            episodes: episodes,
          );
        }).toList();

        /// текущая озвучка
        VoiceActing voiceActing = const VoiceActing();

        /// список доступных озвучек
        final voiceActings = <VoiceActing>[];

        /// парсим список доступных озвучек
        final voiceActingElements =
            document.getElementsByClassName('btn-group btn-group-sm');
        if (voiceActingElements.isNotEmpty) {
          /// ^ если есть доступные озвучки

          /// парсим кнопки с озвучками
          final items = voiceActingElements.first.children;
          for (final item in items) {
            if (item.attributes['disabled'] != null) {
              /// обновляем текущую озвучку
              voiceActing = VoiceActing(
                id: TskgItem.getShowIdFromUrl(showId),
                name: item.text.trim(),
              );
            } else {
              final url = item.attributes['href'] ?? '';

              final id = TskgItem.getShowIdFromUrl(url);

              /// формируем список доступных озвучек
              voiceActings.add(VoiceActing(
                id: id,
                name: item.text,
              ));
            }
          }
        }

        return TskgItem(
          id: showId,
          title: title,
          seasons: seasons,
          originalTitle: originalTitle,
          overview: description,
          year: years,
          genres: genres,
          countries: countries,
          voice: voiceActing,
          voices: voiceActings,
        );
      },
    );
  }

  /// получение информации об эпизоде
  Future<MediaItemEpisode?> getEpisodeDetails(String episodeId) async {
    try {
      /// запрашиваем данные
      final response = await _dio.get(
        '/show/episode/episode.json',
        queryParameters: {
          'episode': episodeId,
        },
        options: Options(
          headers: {
            'x-requested-with': 'XMLHttpRequest',
          },
        ),
      );

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно

        /// возвращаем информацио об эпизоде
        return MediaItemEpisode.fromJson(response.data);
      }
    } catch (exception) {
      /// ^ если прозошла сетевая ошибка

      debugPrint('exception: $exception');
    }

    return null;
  }

  /// поиск сериала
  Future<List<MediaItem>> searchShows(
    String searchQuery, {
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get(
        '/shows/search/$searchQuery',
        cancelToken: cancelToken,
        options: Options(
          headers: {
            'x-requested-with': 'XMLHttpRequest',
          },
        ),
      ),
      decoder: (response) {
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
