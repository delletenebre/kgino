// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// import '../models/tmdb_item.dart';
// import 'interceptors/logs_interceptor.dart';
// import 'models/api_request.dart';
//
// part 'tmdb_api_provider.g.dart';
//
// @Riverpod(keepAlive: true)
// TmdbApi tmdbApi(TmdbApiRef ref) => TmdbApi(ref);
//
// class TmdbApi {
//   final TmdbApiRef ref;
//
//   CancelToken getCancelToken() => CancelToken();
//
//   /// The Movie database
//   final _dio = Dio(BaseOptions(
//     baseUrl: 'https://api.themoviedb.org/3',
//     sendTimeout: const Duration(seconds: 30),
//     receiveTimeout: const Duration(seconds: 30),
//   ));
//
//   TmdbApi(this.ref) {
//     /// добавляем перехватчик, для логов запросов
//     _dio.interceptors.add(LogsInterceptor());
//
//     _dio.options.headers[HttpHeaders.authorizationHeader] =
//         'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZTJkOTAyZmU5ZjNkMTMwN2UzZjJlNzQyYjUyZTYzMSIsInN1YiI6IjYzNzkyMmQ1OTc2ZTQ4MDBkY2Q5NDBhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9AorPdLswBIWNTVBrxq7nFzTWfVktAhOSnDDKsjgWyU';
//   }
//
//   /// список с фильтрацией
//   Future<TmdbItem?> searchMovie({
//     String originalTitle = '',
//     String title = '',
//     String year = '',
//     CancelToken? cancelToken,
//   }) async {
//     return ApiRequest<TmdbItem?>().call(
//       request: _dio.get(
//         '/search/movie',
//         queryParameters: {
//           'query': '$title $originalTitle',
//           'language': 'ru',
//           'primary_release_year': year,
//         },
//         cancelToken: cancelToken,
//       ),
//       decoder: (json) async {
//         final items = json['results'].where((item) =>
//             item['title'] == title || item['original_title'] == originalTitle);
//         debugPrint('tmdb movie $items');
//         if (items.length > 0) {
//           return TmdbItem.fromJson(items.first);
//         }
//
//         return null;
//       },
//     );
//   }
//
//   /// список с фильтрацией
//   Future<TmdbItem?> searchShow({
//     String originalTitle = '',
//     String title = '',
//     String year = '',
//     CancelToken? cancelToken,
//   }) async {
//     return ApiRequest<TmdbItem?>().call(
//       request: _dio.get(
//         '/search/tv',
//         queryParameters: {
//           'query': '$title $originalTitle',
//           'language': 'ru',
//           'first_air_date_year': year,
//         },
//         cancelToken: cancelToken,
//       ),
//       decoder: (json) async {
//         final items = json['results'].where((item) =>
//             item['name'] == title || item['original_name'] == originalTitle);
//         debugPrint('tmdb show $items');
//         if (items.length > 0) {
//           return TmdbItem.fromJson(items.first);
//         }
//
//         return null;
//       },
//     );
//   }
// }
