import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kgino/api/tskg/models/tskg_item.dart';

class TskgApi {
  static const scheme = 'https';
  static const host = 'www.ts.kg';

  static Uri getUri(String path) {
    return Uri(
      scheme: scheme,
      host: host,
      path: path,
    );
  }

  /// получение списка новостей
  static Future<List<TskgItem>> getNews() async {
    
    /// список элементов
    final items = <TskgItem>[];
    
    /// формируем uri запроса
    final url = getUri('/news');

    /// запрашиваем данные
    final response = await http.get(url);

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

            items.add(
              TskgItem(
                date: date,
                title: title,
                subtitle: subtitle,
                link: link,
                genres: genres,
              )
            );

            //debugPrint('---- ---- ----');
          }

        }

      }

    }

    return items;
  }
}