import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/tskg/tskg_item.dart';

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
  Future<List<TskgItem>> getNews() async {
    
    /// список элементов
    final items = <TskgItem>[];

    try {
      /// запрашиваем данные
      final response = await _dio.get('/news');

      if (response.statusCode == 200) {
        // ^ если запрос выполнен успешно
        // парсим html
        final document = parse(response.data);
        
        // получаем элементы списка новых поступлений
        final elements = document.getElementsByClassName('app-news-block');

        for (final element in elements) {

          // парсим дату добавления
          // <div class="app-news-date"><strong>22.12.2021</strong></div>
          final dateText = element
            .getElementsByClassName('app-news-date').first.text;
          final date = DateFormat('dd.MM.yyyy').parse(dateText);

          // парсим элементы новых поступлений
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

              // ссылка на сериал/подборку/серию
              final link = tagA.attributes['href'] ?? '';
              //debugPrint('link: $link');
              
              // название сериала или подборки
              final title = tagA.text;
              //debugPrint('title: $title');

              // дополнительная информация (например, сезон и номер серии)
              String subtitle = '';
              if (tagSmall.isNotEmpty) {
                subtitle = tagSmall.first.text;
              }
              //debugPrint('subtitle: $subtitle');

              // жанры
              final genres = tagA.attributes['title'] ?? '';
              //debugPrint('genres: $genres');

              // значки (badges)
              final badges = listItem.getElementsByClassName('label').map((badge) {
                
                if (badge.text.isEmpty) {
                  // ^ если значок в виде иконки
                  return badge.firstChild?.attributes['title'] ?? '';

                } else {
                  // ^ если значок подписан
                  
                  return badge.text;
                  
                }

              });

              items.add(
                TskgItem(
                  showId: TskgItem.getShowIdFromLink(link),
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


}
