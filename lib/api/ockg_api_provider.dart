import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/foundation.dart';
import 'package:kgino/models/ockg/ockg_bestsellers_category.dart';

import '../constants.dart';
import '../models/movie_item.dart';
import '../models/ockg/ockg_catalog.dart';
import '../models/ockg/ockg_comment.dart';
import '../models/ockg/ockg_movie.dart';

class OckgApiProvider {

  /// cinema online
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://oc.kg/api.php?format=json',
    sendTimeout: requestTimeout.inMilliseconds,
    receiveTimeout: requestTimeout.inMilliseconds,
  ));

  OckgApiProvider() {
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


  /// список бестселлеров по категориям
  Future<List<OckgBestsellersCategory>> getBestsellers() async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getBestsellers',
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
      final bestsellers = jsonResponse['json'][0]['response']['bestsellers'];

      return bestsellers.map<OckgBestsellersCategory>((item) {
        return OckgBestsellersCategory.fromJson(item);
      }).toList();
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return [];
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return [];
    }
    
  }

  
  /// список популярных фильмов
  Future<List<OckgMovie>> getPopMovies() async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getPopMovies',
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
      final movies = jsonResponse['json'][0]['response']['movies'];

      return movies.map<OckgMovie>((item) {
        return OckgMovie.fromJson(item);
      }).toList();
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return [];
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return [];
    }
    
  }


  /// поиск фильмов
  Future<List<OckgMovie>> searchMovies(String searchQuery) async {
    // final runes = searchQuery.runes.map((r) {
    //   return '%u${r.toRadixString(16).padLeft(4, '0')}';
    // }).toList();

    // final formData = FormData.fromMap({
    //   'action[0]': 'Video.search',
    //   'query[0]': searchQuery,
    // });

    try {

      // final response = await _dio.post('', data: formData);
    
      final response = await _dio.get('https://oc.kg/suggestion.php',
        queryParameters: {
          'q': searchQuery,
        }
      );

      final jsonResponse = json.decode(response.data);
      final movies = jsonResponse['json'][0]['response']['movies'];

      return movies.map<OckgMovie>((item) {
        return OckgMovie.fromJson(item);
      }).toList();
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return [];
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return [];
    }

    
  }


  /// список фильмов по id жанра
  Future<List<OckgMovie>> getMoviesByGenreId(int genreId) async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getCatalog',
      'genre[0]': genreId,
      'offset[0]': 0,
      'size[0]': 20,
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
      final movies = jsonResponse['json'][0]['response']['movies'];

      return movies.map<OckgMovie>((item) {
        return OckgMovie.fromJson(item);
      }).toList();
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return [];
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return [];
    }

  }


  /// список фильмов из каталога
  Future<OckgCatalog> getCatalog({
    int genreId = 0,
    required int offset,
    int pageSize = 15,
  }) async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getCatalog',
      if (genreId > 0) 'genre[0]': genreId,
      'offset[0]': offset,
      'size[0]': pageSize,
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
      debugPrint('getCatalog: $jsonResponse');
      final catalog = jsonResponse['json'][0]['response'];

      return OckgCatalog.fromJson(catalog);
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return const OckgCatalog();
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return const OckgCatalog();
    }

  }

  
  /// информация о фильме
  Future<MovieItem?> getMovie(String movieId) async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getMovie',
      'movie_id[0]': movieId,
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
      final movieJson = jsonResponse['json'][0]['response']['movie'];

      final movie = OckgMovie.fromJson(movieJson);

      /// TODO add more info
      return MovieItem(
        type: MovieItemType.ockg,
        id: movie.movieId.toString(),
        name: movie.name,
        posterUrl: movie.posterUrl
      );
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return null;
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return null;
    }

  }


  /// комментарии к фильму
  Future<List<OckgComment>> getComments(int movieId) async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getComments',
      'movie_id[0]': movieId,
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
      final movies = jsonResponse['json'][0]['response']['comments'];

      return movies.map<OckgComment>((item) {
        return OckgComment.fromJson(item);
      }).toList();
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return [];
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return [];
    }

  }

}
