import 'dart:convert';
import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';
import 'package:kgino/api/tskg/models/tskg_episode_details.dart';
import 'package:kgino/api/tskg/models/tskg_item.dart';
import 'package:kgino/api/tskg/models/tskg_search.dart';
import 'package:kgino/api/tskg/models/tskg_season.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/utils/utils.dart';

class TskgApi {
  /// время ожидания ответа от сервера
  static const timeout = Duration(seconds: 30);

  static const baseUrl = 'https://www.ts.kg';

  static final dio = Dio();

  TskgApi() {

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeout.inMilliseconds,
      receiveTimeout: timeout.inMilliseconds,
      headers: {
        'User-Agent': 'kgino/${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
      },
    );

    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest:(options, handler) {
    //     /// действия перед тем, как запрос будет отправлен

    //     /// дополнительные заголовки запроса
    //     final headers = <String, String>{
    //       'User-Agent': 'okhttp/3.11.0',
    //     };

    //     /// добавляем заголовки в запрос
    //     options.headers.addAll(headers);
        
    //     return handler.next(options);
    //   },

    //   onResponse:(response, handler) {
    //     // Do something with response data

    //     debugPrint('==== API RESPONSE ====');
    //     debugPrint('uri : ${response.realUri}');
    //     //debugPrint('data: ${response.data}');
    //     debugPrint('==== ==== ====\n\n');

    //     return handler.next(response);
    //   },

    //   onError: (error, handler) {
    //     // Do something with response error

    //     debugPrint('==== API RESPONSE ====');
    //     debugPrint('uri : ${error.response?.realUri}');
    //     debugPrint('data: $error');
    //     debugPrint('==== ==== ====\n\n');

    //     return  handler.next(error);
    //   }
    // ));

  }

  /// формируем полную ссылку на постер сериала по id
  static String getPosterUrl(String showId) {
    return '$baseUrl/posters/$showId.png';
  }

  /// формируем полную ссылку на сериал по id
  static String getShowUrl(String showId) {
    return '$baseUrl/show/$showId';
  }

  /// получение списка новостей
  Future<List<TskgItem>> getNews() async {
    
    /// список элементов
    final items = <TskgItem>[];

    try {
      /// запрашиваем данные
      final response = await dio.get('/news');

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
          /// <div class="app-news-list-item">
          ///   <div class="clearfix news">
          ///     <i class="fas fa-caret-right"></i>
          ///     <span class="label label-default"><span class="fas fa-sync-alt" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Обновлено"></span></span>
          ///     <a class="news-link app-news-link" href="/show/zhenskii_stand_up/3/16" data-toggle="tooltip" data-placement="top" title="ТВ-шоу (российские), Стендап, Юмористическое шоу">Женский стендап</a>
          ///     <span class="text-muted clearfix"><small>3 сезон, 16 серия</small></span>
          ///   </div>
          /// </div>
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
              final genres = tagA.attributes['title'] ?? '';
              //debugPrint('genres: $genres');

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
                TskgItem(
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
      final response = await dio.get(getShowUrl(showId));

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
          String countryImageUrl = element.attributes['style'] ?? '';
          if (countryImageUrl.startsWith('background-image: url(')) {
            /// ^ если ссылка на изображение страны не пустая
            
            /// вырезаем [background-image: url(https://www.ts.kg/img/flags/svg/4x3/ru.svg)]
            countryImageUrl = countryImageUrl
              .substring(22, countryImageUrl.length - 1);
          }

          return Country(
            name: countryName,
            imageUrl: countryImageUrl,
          );
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
          id: showId,
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

    return TskgShow();
  }


  /// получение информации о эпизоде
  Future<TskgEpisodeDetails?> getEpisodeDetails(int episodeId) async {

    try {

      /// запрашиваем данные
      final response = await dio.get('/show/episode/episode.json',
        queryParameters: {
          'episode': '$episodeId',
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
        return TskgEpisodeDetails.fromJson(response.data);

      }
    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return null;
  }


  /// поиск сериала
  Future<List<TskgSearch>> search(String searchQuery) async {

    final items = <TskgSearch>[];

    try {

      /// запрашиваем данные
      final response = await dio.get('/show/search/$searchQuery',
        options: Options(
          headers: {
            'x-requested-with': 'XMLHttpRequest',
          },
        ),
      );

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно

        final jsonItems = json.decode(response.data);

        for (final item in jsonItems) {
          items.add(TskgSearch.fromJson(item));
        }

      }

    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return items;
  }



  static String getTextByClassName(Document document, String className) {
    final elements = document.getElementsByClassName(className);
    if (elements.isNotEmpty) {
      return elements.first.text.trim();
    }

    return '';
  }
}

class ApiException implements Exception {
  /// код HTTP-ответа
  final int statusCode;

  /// A message describing the format error.
  final String message;


  const ApiException({
    required this.statusCode,
    this.message = '',
  });

  @override
  String toString() => 'ApiException >>> Code: $statusCode >> $message';
}
