import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/filmix/filmix_item.dart';
import '../models/media_item.dart';
import '../models/tmdb_movie.dart';
import 'interceptors/logs_interceptor.dart';
import 'models/api_request.dart';

// import '../models/api_response.dart';
// import '../models/device_details.dart';
// import '../models/flmx/flmx_item.dart';
// import '../models/flmx/flmx_profile.dart';
// import '../models/flmx/flmx_token.dart';
// import '../models/kgino_item.dart';
// import '../providers/providers.dart';
// import 'api_request.dart';
// import 'logs_interceptor.dart';

part 'tmdb_api_provider.g.dart';

@Riverpod(keepAlive: true)
TmdbApi tmdbApi(TmdbApiRef ref) => TmdbApi(ref);

class TmdbApi {
  final TmdbApiRef ref;

  CancelToken getCancelToken() => CancelToken();

  /// The Movie database
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  TmdbApi(this.ref) {
    /// добавляем перехватчик, для логов запросов
    _dio.interceptors.add(LogsInterceptor());

    _dio.options.headers[HttpHeaders.authorizationHeader] =
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZTJkOTAyZmU5ZjNkMTMwN2UzZjJlNzQyYjUyZTYzMSIsInN1YiI6IjYzNzkyMmQ1OTc2ZTQ4MDBkY2Q5NDBhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9AorPdLswBIWNTVBrxq7nFzTWfVktAhOSnDDKsjgWyU';
  }

  /// список с фильтрацией
  Future<MediaItem?> searchMovie({
    String title = '',
    String year = '',
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<MediaItem?>().call(
      request: _dio.get(
        '/search/movie',
        queryParameters: {
          'query': title,
          'language': 'ru',
          'primary_release_year': year,
        },
        cancelToken: cancelToken,
      ),
      decoder: (json) {
        if (json['results'].length > 0) {
          final tmdbMovie = TmdbMovie.fromJson(json['results'].first);
          return tmdbMovie.toMediaItem();
        }
        // return json.map<MediaItem>((item) {
        //   return FilmixItem.fromJson(item).toMediaItem();
        // }).toList();

        return null;
      },
    );
  }
}
