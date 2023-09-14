import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:kgino/resources/krs_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../models/api_response.dart';
import '../models/device_details.dart';
import '../models/flmx/flmx_item.dart';
import '../models/flmx/flmx_profile.dart';
import '../models/flmx/flmx_token.dart';
import '../models/kgino_item.dart';
import '../providers/providers.dart';
import 'api_request.dart';
import 'logs_interceptor.dart';

part 'flmx_api_provider.g.dart';

@Riverpod(keepAlive: true)
FlmxApi api(ApiRef ref) => FlmxApi(ref);

class FlmxApi {
  final ApiRef ref;

  static const String _apkVersion = '2.0.9';

  late final Map<String, String> _queryParams;

  /// cinema online
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://filmixapp.cyou/api/v2',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  FlmxApi(this.ref) {
    /// добавляем перехватчик, для логов запросов
    _dio.interceptors.add(LogsInterceptor());

    /// хранилище данных
    final storage = ref.read(storageProvider);

    String authToken =
        storage.sharedStorage.getString('filmix_auth_token') ?? '';
    if (authToken.isEmpty) {
      authToken = md5
          .convert(const Uuid().v4().codeUnits)
          .toString(); //.substring(0, 18);
      storage.sharedStorage.setString('filmix_auth_token', authToken);
    }

    String deviceId = storage.sharedStorage.getString('filmix_device_id') ?? '';
    if (deviceId.isEmpty) {
      deviceId =
          md5.convert(const Uuid().v4().codeUnits).toString().substring(0, 16);
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
      request: _dio.get('/search',
          queryParameters: {..._queryParams, 'story': searchQuery}),
      decoder: (json) async {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

  /// детали фильма или сериала
  Future<ApiResponse<KginoItem>> getMovieDetails(
    String id, {
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<KginoItem>().call(
      request: _dio.get(
        '/post/$id',
        queryParameters: {
          ..._queryParams,
        },
        cancelToken: cancelToken,
      ),
      decoder: (json) async {
        return FlmxItem.fromJson(json).toMovieItem();
      },
    );
  }

  /// список новых фильмов
  Future<ApiResponse<List<KginoItem>>> getLatestMovies() async {
    return getFiltered(['s0', 's14'], 1);
  }

  /// список популярных фильмов
  Future<ApiResponse<List<KginoItem>>> getPopularMovies() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/popular', queryParameters: {
        ..._queryParams,
        'section': '0',
      }),
      decoder: (json) async {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

  /// список фильмов по категории
  Future<ApiResponse<List<KginoItem>>> getMoviesByCategory(
    String categoryId, {
    int page = 1,
  }) async {
    return getFiltered(['s0', 's14', categoryId], page);
  }

  /// список сериалов по категории
  Future<ApiResponse<List<KginoItem>>> getShowsByCategory(
    String categoryId, {
    int page = 1,
  }) async {
    return getFiltered(['s7', 's93', categoryId], page);
  }

  /// список с фильтрацией
  Future<ApiResponse<List<KginoItem>>> getFiltered(
      List<String> filter, int page) async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/catalog', queryParameters: {
        ..._queryParams,
        'orderby': 'date',
        'orderdir': 'desc',
        'filter': filter.join('-'),
        'page': page,
      }),
      decoder: (json) async {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

  /// список новых сериалов
  Future<ApiResponse<List<KginoItem>>> getLatestShows() async {
    return getFiltered(['s7', 's93'], 1);
  }

  /// список популярных сериалов
  Future<ApiResponse<List<KginoItem>>> getPopularShows() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/popular', queryParameters: {
        ..._queryParams,
        'section': '7',
      }),
      decoder: (json) async {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

  /// поиск фильмов
  Future<ApiResponse<List<KginoItem>>> searchMovies(String searchQuery) async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/search', queryParameters: {
        ..._queryParams,
        'story': searchQuery,
      }),
      decoder: (json) async {
        return json.map<KginoItem>((item) {
          return FlmxItem.fromJson(item).toMovieItem();
        }).toList();
      },
    );
  }

  /// запрос ключа авторизации
  Future<ApiResponse<FlmxToken>> getToken({
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<FlmxToken>().call(
      request: _dio.get(
        '/token_request',
        queryParameters: {
          ..._queryParams,
        },
        cancelToken: cancelToken,
      ),
      decoder: (json) async {
        final token = FlmxToken.fromJson(json);

        /// хранилище данных
        final storage = GetIt.instance<KrsStorage>();

        storage.sharedStorage.setString('filmix_auth_token', token.code);

        _queryParams['user_dev_token'] = token.code;

        return token;
      },
    );
  }

  /// запрос профиля пользователя
  Future<ApiResponse<FlmxProfile>> getProfile({
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<FlmxProfile>().call(
      request: _dio.get(
        '/user_profile',
        queryParameters: {
          ..._queryParams,
        },
        cancelToken: cancelToken,
      ),
      decoder: (json) async {
        return FlmxProfile.fromJson(json);
      },
    );
  }

  /// список категорий
  Future<ApiResponse<List<KginoItem>>> getCategories() async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/category_list', queryParameters: {
        ..._queryParams,
      }),
      decoder: (json) async {
        final categories = <KginoItem>[];
        Map.from(json).forEach((key, value) {
          categories.add(KginoItem(
            provider: KginoProvider.flmxMovie.name,
            id: key.toString().replaceAll('f', 'g'),
            name: value,
            posterUrl: '',
            isFolder: true,
          ));
        });

        return categories;
      },
    );
  }
}
