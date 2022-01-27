import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kgino/api/tskg/models/tskg_episode.dart';
import 'package:kgino/api/tskg/models/tskg_item.dart';
import 'package:kgino/api/tskg/models/tskg_season.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/utils/utils.dart';

class TskgApi {
  /// время ожидания ответа от сервера
  static const timeout = Duration(seconds: 5);

  static const scheme = 'https';
  static const host = 'www.ts.kg';

  /// формируем полную ссылку по относительному пути
  static Uri getUri(String path) {
    return Uri(
      scheme: scheme,
      host: host,
      path: path,
    );
  }

  /// формируем полную ссылку на постер сериала по id
  static String getPosterUrl(String showId) {
    final url = getUri('/posters/$showId.png');
    return url.toString();
  }

  /// формируем полную ссылку на сериал по id
  static String getShowUrl(String showId) {
    final url = getUri('/show/$showId');
    return url.toString();
  }

  /// формируем полную ссылку на эпизод сериал по относительной ссылке
  static String getEpisodeUrl(String relativeUrl) {
    final url = getUri(relativeUrl);
    return url.toString();
  }

  /// получение списка новостей
  static Future<List<TskgItem>> getNews() async {
    
    /// список элементов
    final items = <TskgItem>[];
    
    /// формируем uri запроса
    final url = getUri('/news');

    try {
      /// запрашиваем данные
      final response = await http.get(url).timeout(timeout);

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно

        /// парсим html
        final document = parse(response.body);
        
        /// получаем элементы списка новых поступлений
        final elements = document.getElementsByClassName('app-news-block');

        for (final element in elements) {

          /// парсим дату добавления
          /// <div class="app-news-date"><strong>22.12.2021</strong></div>
          final dateText = element
            .getElementsByClassName('app-news-date').first.text;
          final date = DateFormat('dd.mm.yyyy').parse(dateText);


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

                  final text = badge.firstChild?.attributes['title'] ?? '';

                  switch (text) {
                    case 'Временно':
                      return TskgBagdeType.temporarily;

                    case 'Обновлено':
                      return TskgBagdeType.updated;
                  }
                
                } else {
                  /// ^ если значок подписан
                  
                  switch (badge.text) {
                    case 'Топ':
                      return TskgBagdeType.top;
                    
                    case 'Новое':
                      return TskgBagdeType.newest;

                    case 'Финал':
                      return TskgBagdeType.finale;

                    case 'Подборка':
                      return TskgBagdeType.compilation;

                    case 'Важно':
                      return TskgBagdeType.important;

                    case 'Новогоднее':
                      return TskgBagdeType.newyear;
                  }
                }
                

                /// если значок в виде иконки
                /// TODO fix
                return TskgBagdeType.unknown;

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
      
      
      debugPrint('http error: $url');
    }

    return items;
  }


  /// получение информации о сериале
  static Future<TskgShow> getShow(String showId) async {
    /// формируем uri запроса
    final url = Uri.parse(getShowUrl(showId));

    debugPrint('url: $url');

    try {
      /// запрашиваем данные
      final response = await http.get(url).timeout(timeout);

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно

        /// парсим html
        final document = parse(response.body);

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
      
      
      debugPrint('http error: $url');
    }

    return TskgShow();
  }

  static String getTextByClassName(Document document, String className) {
    final elements = document.getElementsByClassName(className);
    if (elements.isNotEmpty) {
      return elements.first.text.trim();
    }

    return '';
  }
}

enum TskgBagdeType {
  /// новое
  newest,

  /// топ
  top,

  /// обновлено
  updated,

  /// временно
  temporarily,

  /// финал
  finale,

  /// подборка
  compilation,

  /// важно
  important,

  /// новогоднее
  newyear,

  /// неизвестно
  unknown,
}