import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';

import '../models/api_response.dart';
import '../models/kgino_item.dart';
import '../models/tskg/tskg_episode_details.dart';
import '../models/tskg/tskg_show.dart';
import 'api_request.dart';
import 'logs_interceptor.dart';
import 'tskg_api_isolates.dart';


final userAgent = 'KGino/${kIsWeb ? 'Web' : Platform.operatingSystem} ${kIsWeb ? 'Web' : Platform.operatingSystemVersion}';

class TskgApiProvider {

  /// ts.kg
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://www.ts.kg',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'User-Agent': userAgent,
    },
  ));

  TskgApiProvider() {
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

  /// получение списка новостей
  Future<List<KginoItem>> getNews() async {
    try {

      /// запрашиваем данные
      final response = await _dio.get('/news');

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно
        
        final html = response.data.toString();

        return await compute(newsIsolate, html);

      }
    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return [];
  }


  /// список новых
  Future<ApiResponse<List<KginoItem>>> getLatestShows() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/'),
      decoder: (response) async {
        final html = response.toString();  

        return await compute(newSectionIsolate, html);
      },
    );
    
  }

  /// список популярных
  Future<ApiResponse<List<KginoItem>>> getPopularShows() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/'),
      decoder: (response) async {
        final html = response.toString();  

        return await compute(popularSectionIsolate, html);
      },
    );
    
  }

  // /// получение списка популярных
  // Future<List<KginoItem>> getPopular() async {
  //   try {

  //     /// запрашиваем данные
  //     final response = await _dio.get('/');

  //     if (response.statusCode == 200) {
  //       /// ^ если запрос выполнен успешно
        
        

  //     }
  //   } catch (exception) {
  //     /// ^ если прозошла сетевая ошибка
      
  //     debugPrint('exception: $exception');
  //   }

  //   return [];
  // }

  // /// получение списка новых
  // Future<List<KginoItem>> getNew() async {
  //   try {

  //     /// запрашиваем данные
  //     final response = await _dio.get('/');

  //     if (response.statusCode == 200) {
  //       /// ^ если запрос выполнен успешно
        
  //       final html = response.data.toString();  

  //       return await compute(newSectionIsolate, html);

  //     }
  //   } catch (exception) {
  //     /// ^ если прозошла сетевая ошибка
      
  //     debugPrint('exception: $exception');
  //   }

  //   return [];
  // }


  /// получение информации о сериале
  Future<KginoItem> getShow(String showId) async {
    try {
      /// запрашиваем данные
      final response = await _dio.get(getShowUrlById(showId));

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно
        
        final html = response.data.toString();  

        return await compute(showIsolate, html);
      }

    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return KginoItem(
      id: '',
      name: '', posterUrl: '', provider: '',
    );
  }


  /// получение информации об эпизоде
  Future<TskgEpisodeDetails?> getEpisodeDetails(String episodeId) async {

    try {

      /// запрашиваем данные
      final response = await _dio.get('/show/episode/episode.json',
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
        return TskgEpisodeDetails.fromJson(response.data);
      }
    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return null;
  }


  /// поиск сериала
  Future<List<KginoItem>> searchShows(String searchQuery) async {

    final items = <KginoItem>[];

    if (searchQuery.isNotEmpty) {
      /// ^ если запрос не пустой
      
      try {

        /// запрашиваем данные
        final response = await _dio.get('/shows/search/$searchQuery',
          options: Options(
            headers: {
              'x-requested-with': 'XMLHttpRequest',
            },
          ),
        );

        if (response.statusCode == 200) {
          /// ^ если запрос выполнен успешно
          final jsonItems = response.data;

          for (final item in jsonItems) {
            final name = item['name'];
            final url = item['url'];

            if (url.startsWith('/show/')) {
              items.add(
                KginoItem(
                  id: TskgShow.getShowIdFromUrl(url),
                  name: name, posterUrl: '', provider: '',
                )
              );
            }
          }

        }

      } catch (exception) {
        /// ^ если прозошла сетевая ошибка
        
        debugPrint('exception: $exception');
      }

    }

    return items;
  }


}
