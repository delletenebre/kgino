import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LogsInterceptor extends InterceptorsWrapper {

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
      
      print("| [DIO] Response [code ${response.statusCode}]: ${response.data}");
      // try {
      //   log("| [DIO] Response [code ${response.statusCode}]: ${jsonEncode(response.data)}");
      // } catch(exception) {
      //   log("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
      // }
      print("└------------------------------------------------------------------------------");
    }

    handler.next(response);
  }

  @override
  onError(DioError err, handler) async {
    if (kDebugMode) {
      /// ^ если режим отладки
      
      log("| [DIO] Error: ${err.error}: ${err.response.toString()}");
      print("└------------------------------------------------------------------------------");
    }

    handler.next(err);
  }
}