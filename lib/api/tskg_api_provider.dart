import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/tskg/tskg_episode.dart';
import '../models/tskg/tskg_season.dart';
import '../models/tskg/tskg_show.dart';
import '../utils.dart';

class TskgApiProvider {

  /// ts.kg
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://ts.kg',
    sendTimeout: requestTimeout.inMilliseconds,
    receiveTimeout: requestTimeout.inMilliseconds,
    headers: {
      'User-Agent': userAgent,
    },
  ));

  TskgApiProvider() {
    _dio.interceptors.add(
      DioCacheManager(
        CacheConfig(
          baseUrl: _dio.options.baseUrl,
          defaultMaxAge: cacheMaxAge,
          defaultMaxStale: cacheMaxAge,
        )
      ).interceptor
    );
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


  // /// список бестселлеров по категориям
  // Future<List<OckgBestsellersCategory>> getBestsellers() async {

  //   final formData = FormData.fromMap({
  //     'action[0]': 'Video.getBestsellers',
  //   });

  //   try {
    
  //     final response = await _dio.post('', data: formData);

  //     final jsonResponse = json.decode(response.data);
  //     final bestsellers = jsonResponse['json'][0]['response']['bestsellers'];

  //     return bestsellers.map<OckgBestsellersCategory>((item) {
  //       return OckgBestsellersCategory.fromJson(item);
  //     }).toList();
      
  //   } on SocketException catch (_) {

  //     debugPrint('no internet connection');
      
  //     return [];
    
  //   } catch (exception, stacktrace) {
      
  //     debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
  //     return [];
  //   }
    
  // }

  /// получение списка новостей
  Future<List<TskgShow>> getNews() async {
    
    /// список элементов
    final items = <TskgShow>[];

    try {
      /// запрашиваем данные
      final response = await _dio.get('/news');

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(response.data);
        
        /// получаем элементы списка новых поступлений
        final elements = document.getElementsByClassName('app-news-block');

        for (final element in elements) {

          /// парсим дату добавления
          /// <div class="app-news-date"><strong>22.12.2021</strong></div>
          final dateText = element
            .getElementsByClassName('app-news-date').first.text;
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
          final listItems = element.getElementsByClassName('app-news-list-item');
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
              //debugPrint('subtitle: $subtitle');

              /// жанры
              /// data-original-title
              final genres = (tagA.attributes['title'] ?? '').split(', ');
              // debugPrint('genres: $genres');

              /// значки (badges)
              final badges = listItem.getElementsByClassName('label').map((badge) {
                
                if (badge.text.isEmpty) {
                  /// ^ если значок в виде иконки
                  return badge.firstChild?.attributes['title'] ?? '';

                } else {
                  /// ^ если значок подписан
                  
                  return badge.text;
                  
                }

              });

              items.add(
                TskgShow(
                  showId: TskgShow.getShowIdFromLink(link),
                  date: date,
                  title: title,
                  subtitle: subtitle,
                  link: link,
                  genres: genres,
                  badges: badges.toList(),
                )
              );

              //debugPrint('---- ---- ----');
            }

          }

        }

      }
    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return items;
  }


  /// получение информации о сериале
  Future<TskgShow> getShow(String showId) async {

    try {
      /// запрашиваем данные
      final response = await _dio.get(getShowUrlById(showId));

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(response.data);

        /// парсим название сериала
        final title = document.getElementById('h-show-title')?.text ?? '';

        /// парсим название на языке оригинала
        final originalTitle = getTextByClassName(document, 'app-show-header-title-original');

        /// парсим года выпуска сериала
        final years = getTextByClassName(document, 'app-show-header-years');

        /// парсим страны, жанры
        final tags = document.getElementsByClassName('app-show-tags')
          .first
          .getElementsByTagName('a');
        final genres = tags.where((element) {
          /// получаем атрибут href
          final href = element.attributes['href'] ?? '';

           /// находим только те элементы, которые указывают жанр сериала
          return href.startsWith('/category') || href.startsWith('/genre');
        }).map((element) => element.text).toList();
        // debugPrint('show genres: $genres');

        /// формируем список стран
        final countries = tags.where((element) {
          /// получаем атрибут href
          final href = element.attributes['href'] ?? '';

          /// находим только те элементы, которые указывают на страну
          return href.startsWith('/show?country');
        }).map((element) {
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

          return countryName;
          // return TskgCountry(
          //   name: countryName,
          //   imageUrl: countryImageUrl,
          // );
        }).toList();

        /// парсим описание сериала
        final description = getTextByClassName(document, 'app-show-description');

        /// парсим список сезонов
        final seasonElements = document.getElementsByClassName('app-show-seasons-section-full');
        
        /// формируем сезоны сериала
        final seasons = seasonElements.map((season) {
          /// парсим заголовок названия сезона
          final seasonTitleTable = season.getElementsByClassName('app-show-season-title-table').first;
          
          /// получаем название сезона
          final seasonTitle = seasonTitleTable.getElementsByTagName('a').first.text;

          /// парсим список эпизодов сезона
          final seasonEpisodesTable = season.getElementsByClassName('app-show-season-collapse').first;
          final seasonEpisodeRows = seasonEpisodesTable.getElementsByTagName('tr');
          
          /// формируем эпизоды сезона
          final episodes = seasonEpisodeRows.map((episodeRow) {
            /// парсим качество записи SD|HD
            final episodeQuality = episodeRow.getElementsByClassName('btn btn-default btn-xs').first.text;
            
            /// парсим название и id эпизода
            final episodeTitleElement = episodeRow.getElementsByClassName('text-primary').first;
            final episodeTitle = episodeTitleElement.text;
            // final episodeUrl = episodeTitleElement.attributes['href'] ?? '';
            final episodeIdAttribute = episodeTitleElement.attributes['id'] ?? '-';
            final episodeId = int.tryParse(episodeIdAttribute.split('-').last) ?? 0;
            
            /// парсим продолжительность эпизода
            final episodeDurationString = episodeTitleElement.nextElementSibling?.text.trim() ?? '';
            Duration episodeDuration = Duration.zero;
            if (episodeDurationString.isNotEmpty) {
              /// ^ если указана продолжительность эпизода
              
              episodeDuration = Utils.parseDuration(episodeDurationString.substring(2));
            }
            
            /// парсим описание эпизода (перевод, обычно)
            final episodeDescription = episodeRow.getElementsByClassName('text-muted clearfix').first.text.trim().replaceAll('⠀', '');

            return TskgEpisode(
              id: episodeId,
              showId: showId,
              title: episodeTitle,
              description: episodeDescription,
              quality: episodeQuality,
              duration: episodeDuration,
            );
          }).toList();

          return TskgSeason(
            title: seasonTitle,
            episodes: episodes,
          );
        }).toList();

        return TskgShow(
          showId: showId,
          title: title,
          originalTitle: originalTitle,
          description: description,
          years: years,
          genres: genres,
          countries: countries,
          seasons: seasons,
        );
      }

    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
    }

    return const TskgShow();
  }


}
