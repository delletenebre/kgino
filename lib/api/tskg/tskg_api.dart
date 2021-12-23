import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kgino/api/tskg/models/tskg_news_item.dart';

class TskgApi {
  static const host = 'www.ts.kg';

  /// получение списка новостей
  static Future<List<TskgNewsItem>> getNews() async {
    
    /// список элементов
    final items = <TskgNewsItem>[];
    
    /// формируем uri запроса
    final url = Uri(
      scheme: 'https',
      host: host,
      path: '/news',
    );

    /// запрашиваем данные
    final response = await http.get(url);

    if (response.statusCode == 200) {
      /// ^ если запрос выполнен успешно

      /// парсим html
      final document = parse(response.body);
      
      /// получаем элементы списка новых поступлений
      final elements = document.getElementsByClassName('row app-news-block');

      for (final element in elements) {

        /// парсим дату
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
          debugPrint('date: $DateFormat.ABBR_WEEKDAY');

          final tagA = listItem.getElementsByClassName('app-news-link').first;
          final tagSmall = listItem.getElementsByTagName('small');

          /// ссылка на сериал/подборку/серию
          final link = tagA.attributes['href'];
          debugPrint('link: $link');
          
          /// название сериала или подборки
          final title = tagA.text;
          debugPrint('title: $title');

          /// дополнительная информация (например, сезон и номер серии)
          String subtitle = '';
          if (tagSmall.isNotEmpty) {
            subtitle = tagSmall.first.text;
          }
          debugPrint('subtitle: $subtitle');

          items.add(
            TskgNewsItem(
              date: date,
              title: title,
              subtitle: subtitle,
            )
          );

        }

      }

    }

    return items;
  }
}