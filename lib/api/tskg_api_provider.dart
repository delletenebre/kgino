import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';

import '../constants.dart';
import '../models/movie_item.dart';
import '../models/tskg/tskg_episode_details.dart';
import '../models/tskg/tskg_show.dart';
import 'tskg_api_isolates.dart';



class TskgApiProvider {

  /// ts.kg
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://www.ts.kg',
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

  /// получение списка новостей
  Future<List<TskgMovieItem>> getNews() async {
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


  /// получение списка популярных
  Future<List<MovieItem>> getPopular() async {
    try {

      /// запрашиваем данные
      final response = await _dio.get('/');

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно
        
        final html = response.data.toString();  

        return await compute(popularSectionIsolate, html);

      }
    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return [];
  }

  /// получение списка новых
  Future<List<MovieItem>> getNew() async {
    try {

      /// запрашиваем данные
      final response = await _dio.get('/');

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно
        
        final html = response.data.toString();  

        return await compute(newSectionIsolate, html);

      }
    } catch (exception) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return [];
  }


  /// получение информации о сериале
  Future<TskgMovieItem> getShow(String showId) async {
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

    return TskgMovieItem(
      id: '',
      name: '',
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
  Future<List<MovieItem>> searchShows(String searchQuery) async {

    final items = <MovieItem>[];

    if (searchQuery.isNotEmpty) {
      /// ^ если запрос не пустой
      
      try {

        /// запрашиваем данные
        final response = await _dio.get('/show/search/$searchQuery',
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
                TskgMovieItem(
                  id: TskgShow.getShowIdFromUrl(url),
                  name: name,
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
