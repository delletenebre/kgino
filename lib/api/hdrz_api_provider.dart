import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:html/parser.dart';
import 'package:isar/isar.dart';
import 'package:kgino/resources/krs_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/api_response.dart';
import '../models/device_details.dart';
import '../models/flmx/flmx_item.dart';
import '../models/flmx/flmx_profile.dart';
import '../models/flmx/flmx_token.dart';
import '../models/kgino_item.dart';
import 'api_request.dart';
import 'logs_interceptor.dart';

class HdrzApiProvider {

  /// cinema online
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://hdrzk.org',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'x-app-hdrezka-app': 1,
    }
  ));

  HdrzApiProvider() {
    /// добавляем перехватчик, для логов запросов
    _dio.interceptors.add(LogsInterceptor());
  }

  /// список новых фильмов
  Future<ApiResponse<List<KginoItem>>> getLatestMovies({
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<List<KginoItem>>().call(
      request: _dio.get('/page/1/?filter=last&genre=1'),
      decoder: (html) async {
        final items = <KginoItem>[];

        /// парсим html
        final document = parse(html);
        
        /// получаем элементы списка новых поступлений
        final elements = document.getElementsByClassName('b-content__inline_item');

        for (final element in elements) {

          final id = element.attributes['data-id'] ?? '';

          /// парсим постер
          /// <div class="app-news-date"><strong>22.12.2021</strong></div>
          final posterUrl = element.getElementsByTagName('img').first.attributes['src'] ?? '';


          /// парсим название и ссылку
          final div = element.getElementsByClassName('b-content__inline_item-link').first;
          final link = div.getElementsByTagName('a').first;

          final name = link.text;
          //final id = link.attributes['href'] ?? '';
          
          items.add(
            KginoItem(
              provider: KginoProvider.hdrz.name,
              id: id,
              name: name,
              posterUrl: posterUrl,
            )
          );

        }

        return items;
      },
    );
  }


  /// список новых фильмов
  Future<ApiResponse<KginoItem>> getMovieDetails(String id, {
    CancelToken? cancelToken,
  }) async {
    return ApiRequest<KginoItem>().call(
      request: _dio.get('/films/$id-a.html'),
      decoder: (html) async {

        /// парсим html
        final document = parse(html);

        /// парсим озвучку
        final translatorsElements = document.getElementsByClassName('b-translator__item');

        final movieId = '';
        
        return KginoItem(
          provider: KginoProvider.hdrz.name,
          id: 'id',
          name: 'name',
          posterUrl: 'posterUrl',
        );

      },
    );
  }

}
