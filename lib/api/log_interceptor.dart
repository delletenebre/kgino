import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LogInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, handler) {
    if (kDebugMode) {
      /// ^ если режим отладки
      
      print("┌------------------------------------------------------------------------------");
      print('| [DIO] Request: ${options.method} ${options.uri}');
      print('| ${options.data.toString()}');
      print('| Headers:');
      options.headers.forEach((key, value) {
        debugPrint('|\t$key: $value');
      });
      print("├------------------------------------------------------------------------------");
    }

    handler.next(options);
  }

  @override
  onResponse(Response response, handler) async {
    if (kDebugMode) {
      /// ^ если режим отладки
      
      print("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
      print("└------------------------------------------------------------------------------");
    }

    handler.next(response);
  }

  @override
  onError(DioError error, handler) async {
    if (kDebugMode) {
      /// ^ если режим отладки
      print("| [DIO] Error: ${error.error}: ${error.response.toString()}");
      print("└------------------------------------------------------------------------------");
    }

    handler.next(error);
  }
}