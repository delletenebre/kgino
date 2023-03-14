import 'package:dio/dio.dart';

class LogInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, handler) {
    print("┌------------------------------------------------------------------------------");
    print('| [DIO] Request: ${options.method} ${options.uri}');
    print('| ${options.data.toString()}');
    print('| Headers:');
    options.headers.forEach((key, value) {
      print('|\t$key: $value');
    });
    print("├------------------------------------------------------------------------------");
    handler.next(options);
  }

  @override
  onResponse(Response response, handler) async {
    print("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
    print("└------------------------------------------------------------------------------");
    handler.next(response);
  }

  @override
  onError(DioError error, handler) async {
    print("| [DIO] Error: ${error.error}: ${error.response.toString()}");
    print("└------------------------------------------------------------------------------");
    handler.next(error);
  }
}