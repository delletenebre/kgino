import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  /// cinema online
  final _ockg = Dio(BaseOptions(
    baseUrl: 'https://oc.kg/',
    sendTimeout: 30 * 1000,
    receiveTimeout: 30 * 1000,
  ));

  /// ts.kg
  final _tskg = Dio(BaseOptions(
    baseUrl: 'https://www.ts.kg/',
    sendTimeout: 30 * 1000,
    receiveTimeout: 30 * 1000,
  ));

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