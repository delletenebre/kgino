import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiRequest<T> {
  Future<T> call({
    required Future<Response<dynamic>> request,
    required Future<T> Function(dynamic json) decoder,
    FutureOr<T> Function(Object error)? onError,
  }) async {
    try {
      final response = await request;
      return decoder(response.data);
    } on DioException catch (dioException) {
      if (onError != null) {
        return onError(dioException);
      }

      if (dioException.response != null) {
        final headers = dioException.response!.headers;
        final data = dioException.response!.data;
        final hasContentType = (headers.map['content-type'] is List);

        if (!hasContentType ||
            !(headers.map['content-type'] as List)
                .contains('application/json')) {
          throw const ApiError(
            message: 'Непредвиденная ошибка сервера',
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

        /// ошибки валидации
        throw ApiError(
          message: message,
          errors: errors,
        );
      }

      throw const ApiError(
        message: 'Отсутствует связь с сервером',
      );
    } on SocketException catch (exception) {
      debugPrint('no internet connection');

      if (onError != null) {
        return onError(exception);
      }

      throw const ApiError(
        message: 'Отсутствует связь с сервером',
      );
    } catch (exception, stacktrace) {
      debugPrint('Exception: $exception, stacktrace: $stacktrace');

      if (onError != null) {
        return onError.call(exception);
      }

      throw ApiError(
        message: exception.toString(),
      );
    }
  }
}

class ApiError<T> implements Exception {
  final String message;
  final Map<String, String> errors;

  const ApiError({
    this.message = '',
    this.errors = const {},
  });
}
