import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/foundation.dart';
import 'package:kgino/models/ockg/ockg_bestsellers_category.dart';

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


  Future<OckgMovie?> getMovie(String movieId) async {

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