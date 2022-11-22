import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/foundation.dart';
import 'package:kgino/models/ockg/ockg_bestsellers_category.dart';

import '../models/ockg/ockg_catalog.dart';
import '../models/ockg/ockg_movie.dart';

class OckgApiProvider {
  /// cinema online
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://oc.kg/api.php?format=json',
    sendTimeout: 30 * 1000,
    receiveTimeout: 30 * 1000,
  ));

  OckgApiProvider() {
    _dio.interceptors.add(
      DioCacheManager(
        CacheConfig(
          baseUrl: _dio.options.baseUrl,
          defaultMaxAge: const Duration(minutes: 1),
          defaultMaxStale: const Duration(minutes: 1),
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

    final formData = FormData.fromMap({
      'action[0]': 'Video.search',
      'query[0]': searchQuery,
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
    int size = 15,
  }) async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getCatalog',
      if (genreId > 0) 'genre[0]': genreId,
      'offset[0]': offset,
      'size[0]': size,
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
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
  Future<OckgMovie?> getMovie(int movieId) async {

    final formData = FormData.fromMap({
      'action[0]': 'Video.getMovie',
      'movie_id[0]': movieId,
    });

    try {
    
      final response = await _dio.post('', data: formData);

      final jsonResponse = json.decode(response.data);
      final movieJson = jsonResponse['json'][0]['response']['movie'];

      return OckgMovie.fromJson(movieJson);
      
    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return null;
    
    } catch (exception, stacktrace) {
      
      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return null;
    }

    
  }

  // /// получаем профиль пользователя
  // Future<User?> getMe() async {
  //   try {
    
  //     final response = await _dio.get('/auth/profile');

  //     return User.fromJson(response.data['data']);
      
  //   } on SocketException catch (_) {

  //     debugPrint('no internet connection');
      
  //     return null;
    
  //   } catch (exception, stacktrace) {
      
  //     debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
  //     return null;
  //   }

    
  // }

  // /// вход по логину и паролю
  // Future<AuthTokens> signin(String username, String password) async {
  //   final data = {
  //     'username': username,
  //     'password': password,
  //   };

  //   try {
    
  //     final response = await _dio.post('/auth/login', data: data);

  //     return AuthTokens.fromJson(response.data['data']);

  //   } on SocketException catch (_) {

  //     debugPrint('no internet connection');
      
  //     return AuthTokens.withError('CONNECTION');
    
  //   } on DioError catch (dioError) {

  //     debugPrint('DioError: $dioError');
      
  //     return AuthTokens.withError(dioError.type.toString());

  //   } catch (exception, stacktrace) {
      
  //     debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
  //     return AuthTokens.withError('UNKNOWN');
  //   }

    
  // }

  // /// обновление ключа авторизации
  // Future<AuthTokens> refreshToken(String refreshToken) async {
  //   final data = {
  //     'refreshToken': refreshToken,
  //   };

  //   try {
    
  //     final response = await _dio.post('/auth/refresh-token', data: data);

  //     return AuthTokens.fromJson(response.data['data']);
      
  //   } on SocketException catch (_) {

  //     debugPrint('no internet connection');
      
  //     return AuthTokens.withError('CONNECTION');
    
  //   } on DioError catch (dioError) {

  //     debugPrint('DioError: $dioError');
      
  //     return AuthTokens.withError(dioError.type.toString());

  //   } catch (exception, stacktrace) {
      
  //     debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
  //     return AuthTokens.withError('UNKNOWN');
  //   }

    
  // }
}