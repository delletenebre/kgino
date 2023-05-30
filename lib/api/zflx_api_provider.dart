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

class ZflxApiProvider {

  /// ts.kg
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://www.ts.kg',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'User-Agent': userAgent,
    },
  ));

  ZflxApiProvider() {
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

  // /// получение списка новостей
  // Future<List<KginoItem>> getNews() async {
  //   try {

  //     /// запрашиваем данные
  //     final response = await _dio.get('/news');

  //     if (response.statusCode == 200) {
  //       /// ^ если запрос выполнен успешно
        
  //       final html = response.data.toString();

  //       // return await compute(newsIsolate, html);
  //       return await newsIsolate(html);

  //     }
  //   } catch (exception) {
  //     /// ^ если прозошла сетевая ошибка
      
  //     debugPrint('exception: $exception');
  //   }

  //   return [];
  // }

  /// список последних поступлений
  Future<ApiResponse<List<KginoItem>>> getLastEpisodes() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/news'),
      decoder: (response) async {
        final html = response.toString();  

        // return await compute(newSectionIsolate, html);
        return lasEpisodesIsolate(html);
      },
    );
    
  }


  /// список новых
  Future<ApiResponse<List<KginoItem>>> getLatestShows() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/'),
      decoder: (response) async {
        final html = response.toString();  

        // return await compute(newSectionIsolate, html);
        return newSectionIsolate(html);
      },
    );
    
  }

  /// список популярных
  Future<ApiResponse<List<KginoItem>>> getPopularShows() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/'),
      decoder: (response) async {
        final html = response.toString();  

        // return await compute(popularSectionIsolate, html);
        return popularSectionIsolate(html);
      },
    );
    
  }


  /// получение информации о сериале
  Future<ApiResponse<KginoItem>> getShowDetails(String showId, {
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<KginoItem>().call(
      request: _dio.get(getShowUrlById(showId), cancelToken: cancelToken),
      decoder: (response) async {
        final html = response.toString();  

        // return await compute(showIsolate, html);
        return showIsolate(html);
      },
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
  Future<ApiResponse<List<KginoItem>>> searchShows(String searchQuery, {
    CancelToken? cancelToken,
  }) async {

    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/shows/search/$searchQuery',
        cancelToken: cancelToken,
        options: Options(
          headers: {
            'x-requested-with': 'XMLHttpRequest',
          },
        ),
      ),
      decoder: (response) async {
        final items = <KginoItem>[];

        for (final item in response) {
          final name = item['name'];
          final url = item['url'];

          if (url.startsWith('/show/')) {
            final showId = TskgShow.getShowIdFromUrl(url);
            items.add(
              KginoItem(
                id: showId,
                name: name,
                posterUrl: 'https://www.ts.kg/posters2/$showId.png',
                provider: KginoProvider.tskg.name,
              )
            );
          }
        }

        return items;
      },
    );

    // final items = <KginoItem>[];

    // if (searchQuery.isNotEmpty) {
    //   /// ^ если запрос не пустой
      
    //   try {

    //     /// запрашиваем данные
    //     final response = await _dio.get('/shows/search/$searchQuery',
    //       options: Options(
    //         headers: {
    //           'x-requested-with': 'XMLHttpRequest',
    //         },
    //       ),
    //     );

    //     if (response.statusCode == 200) {
    //       /// ^ если запрос выполнен успешно
    //       final jsonItems = response.data;

    //       for (final item in jsonItems) {
    //         final name = item['name'];
    //         final url = item['url'];

    //         if (url.startsWith('/show/')) {
    //           items.add(
    //             KginoItem(
    //               id: TskgShow.getShowIdFromUrl(url),
    //               name: name, posterUrl: '', provider: '',
    //             )
    //           );
    //         }
    //       }

    //     }

    //   } catch (exception) {
    //     /// ^ если прозошла сетевая ошибка
        
    //     debugPrint('exception: $exception');
    //   }

    // }

    // return items;
  }


}
