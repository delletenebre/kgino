import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_request.freezed.dart';

class ApiRequest<T> {
  Future<T> call({
    required Future<Response<dynamic>> request,
    required Future<T> Function(dynamic json) decoder,
  }) async {
    try {
      final response = await request;

      return decoder(response.data);
    } on DioException catch (dioException) {
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
    } on SocketException catch (_) {
      debugPrint('no internet connection');

      throw const ApiError(
        message: 'Отсутствует связь с сервером',
      );
    } catch (exception, stacktrace) {
      debugPrint('Exception: $exception, stacktrace: $stacktrace');

      throw ApiError(
        message: exception.toString(),
      );
    }
  }
}

@Freezed(genericArgumentFactories: true)
class ApiError<T> with _$ApiError<T> implements Exception {
  const factory ApiError({
    @Default('') String message,
    @Default({}) Map<String, String> errors,
  }) = _ApiError;
}
