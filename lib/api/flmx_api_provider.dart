import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../constants.dart';
import '../models/api_response.dart';
import '../models/device_details.dart';
import '../models/flmx/flmx_item.dart';
import '../models/movie_item.dart';
import 'api_request.dart';
import 'logs_interceptor.dart';

class FlmxApiProvider {
  /// информация об устройстве
  final _deviceDetails = GetIt.instance<DeviceDetails>();

  /// cinema online
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://filmixapp.cyou/api/v2',
    sendTimeout: requestTimeout,
    receiveTimeout: requestTimeout,
  ));

  FlmxApiProvider() {
    /// добавляем перехватчик, для логов запросов
    _dio.interceptors.add(LogsInterceptor());
  }


  /// поиск
  Future<ApiResponse<List<MovieItem>>> search(String searchQuery) async {
    return ApiRequest<List<MovieItem>>().call(
      request: _dio.get('/suggest', queryParameters: {
        'word': searchQuery
      }),
      decoder: (json) {
        final Iterable<FlmxItem> movies = json.map<FlmxItem>((item) {
          return FlmxItem.fromJson(item);
        });

        return movies.map<MovieItem>((movie) {
          return MovieItem(
            type: MovieItemType.flmx,
            id: '${movie.id}',
            name: movie.title,
            posterUrl: movie.poster,
          );
        }).toList();
        
      },
    );
  }

  /// детали фильма или сериала  
  Future<ApiResponse<FlmxItem>> getDetails(String id) async {
    return ApiRequest<FlmxItem>().call(
      request: _dio.get('/post/$id', queryParameters: {
        'user_dev_apk': '2.0.9',
        'user_dev_id': _deviceDetails.id,
        'user_dev_name': _deviceDetails.name,
        'user_dev_vendor': _deviceDetails.vendor,
        // 'user_dev_os': '12',
        // 'user_dev_token': '01e439ef4dd5446116ae5ff0e94a22ef',
        // 'user_dev_vendor': 'Google',
      }),
      decoder: (json) {
        return FlmxItem.fromJson(json);
      },
    );
  }

}
