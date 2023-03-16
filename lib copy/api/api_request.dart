import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/api_response.dart';

class ApiRequest<T> {
  /// обновить пользователя
  Future<ApiResponse<T>> call({
    required Future<Response<dynamic>> request,
    required T Function(dynamic json) decoder
  }) async {
    try {
    
      final response = await request;

      final data = decoder(response.data);
      if (response.data is List && response.data.isEmpty) {
        return ApiResponse.empty();
      }

      return ApiResponse.data(data);
      
    } on DioError catch (dioError) {
      
      if (dioError.response != null) {
        final headers = dioError.response!.headers;
        final data = dioError.response!.data;
        
        final hasContentType = (headers.map['content-type'] is List);

        if (!hasContentType || !(headers.map['content-type'] as List).contains('application/json')) {
          return ApiResponse.error(
            message: 'Отсутствует связь с сервером',
          );
        }

        final message = data['message'].toString();

        /// парсим ошибки валидации
        final errors = <String, String>{};
        if (data is Map && data.containsKey('errors')) {
          data['errors'].forEach((key, value) {
            errors[key] = value[0].toString();
          });
        }

        return ApiResponse.error(
          message: message,
          errors: errors,
        );

      }

      return ApiResponse.error(
        message: 'Отсутствует связь с сервером',
      );

    } on SocketException catch (_) {

      debugPrint('no internet connection');
      
      return ApiResponse.error();
    
    } catch (exception, stacktrace) {

      debugPrint('Exception: $exception, stacktrace: $stacktrace');
      
      return ApiResponse.error(
        message: exception.toString(),
      );
    }
    
  }
}