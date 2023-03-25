import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kgino/resources/krs_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/api_response.dart';
import '../models/device_details.dart';
import '../models/flmx/flmx_item.dart';
import '../models/kgino_item.dart';
import 'api_request.dart';
import 'logs_interceptor.dart';

class FlmxApiProvider {
  
  static const String _apkVersion = '2.0.9';

  late final Map<String, String> _queryParams;

  /// cinema online
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://filmixapp.cyou/api/v2',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  FlmxApiProvider() {
    /// добавляем перехватчик, для логов запросов
    _dio.interceptors.add(LogsInterceptor());

    /// хранилище данных
    final storage = GetIt.instance<KrsStorage>();
    
    String authToken = storage.sharedStorage.getString('filmix_auth_token') ?? '';
    if (authToken.isEmpty) {
      authToken = md5.convert(const Uuid().v4().codeUnits).toString().substring(0, 18);
      storage.sharedStorage.setString('filmix_auth_token', authToken);
    }

    String deviceId = storage.sharedStorage.getString('filmix_device_id') ?? '';
    if (deviceId.isEmpty) {
      deviceId = md5.convert(const Uuid().v4().codeUnits).toString().substring(0, 16);
      storage.sharedStorage.setString('filmix_device_id', deviceId);
    }

    /// информация об устройстве
    final deviceDetails = GetIt.instance<DeviceDetails>();

    _queryParams = {
      'user_dev_apk': _apkVersion,
      'user_dev_id': deviceId,
      'user_dev_token': authToken,
      'user_dev_name': deviceDetails.name,
      'user_dev_vendor': deviceDetails.vendor,
      'user_dev_os': deviceDetails.osVersion,
    };
  }


  /// поиск
  Future<ApiResponse<List<KginoItem>>> search(String searchQuery) async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/search', queryParameters: {
        ..._queryParams,
        'story': searchQuery
      }),
      decoder: (json) {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

  /// детали фильма или сериала  
  Future<ApiResponse<KginoItem>> getDetails(String id) async {
    return ApiRequest<KginoItem>().call(
      request: _dio.get('/post/$id', queryParameters: {
        ..._queryParams,
      }),
      decoder: (json) {
        return FlmxItem.fromJson(json).toMovieItem();
      },
    );
  }


  /// список фильмов
  Future<ApiResponse<List<KginoItem>>> getLatestMovies() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/catalog', queryParameters: {
        ..._queryParams,
        'orderby': 'date',
        'orderdir': 'desc',
        'filter': 's0-s14',
      }),
      decoder: (json) {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

  Future<ApiResponse<List<KginoItem>>> getPopularMovies() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/popular', queryParameters: {
        ..._queryParams,
        'filter': 's0-s14',
      }),
      decoder: (json) {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

}
