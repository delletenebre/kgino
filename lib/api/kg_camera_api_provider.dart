import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_request.dart';
import '../models/media_item.dart';

part 'kg_camera_api_provider.g.dart';

@Riverpod(keepAlive: true)
KgCameraApi kgCameraApi(KgCameraApiRef ref) => KgCameraApi(ref);

class KgCameraApi {
  final KgCameraApiRef ref;

  CancelToken getCancelToken() => CancelToken();

  final _dio = Dio(BaseOptions(
    baseUrl: 'https://kg.camera',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  KgCameraApi(this.ref) {
    /// добавляем перехватчик, для логов запросов
    // _dio.interceptors.add(LogsInterceptor());
  }

  /// список камер
  Future<List<MediaItem>> getCameras() async {
    return ApiRequest<List<MediaItem>>().call(
      request: _dio.get('/'),
      decoder: (response) async {
        final html = response.toString();

        final items = <MediaItem>[];

        /// парсим html
        final document = parse(html);

        /// получаем элементы списка новых поступлений
        final elements = document.getElementsByClassName('video-grid-item');

        for (final element in elements) {
          /// <a href="#" class="video-grid-item" data-id="247" data-src="https://webcam.elcat.kg/Bishkek_Ala-Too_Square/index.m3u8" data-preview="/camera/Bishkek_Ala-Too_Square/preview.jpg" data-lat="42.87423182287145" data-lon="74.60415201293377" data-count="127">
          ///     <span title="Сейчас смотрят"><i class="fa fa-eye"></i> <i class="count">127</i></span>
          /// 	<div class="video-title">г.Бишкек, Площадь Ала-Тоо</div>
          /// </a>

          /// парсим идентификатор
          final id = element.attributes['data-id'] ?? '';

          final src = element.attributes['data-src'] ?? '';

          final preview = element.attributes['data-preview'] ?? '';

          final title =
              element.getElementsByClassName('video-title').firstOrNull?.text ??
                  '';

          print(src);
          print(src.replaceAll('index.m3u8', 'tracks-v1/mono.m3u8'));
          final seasons = [
            MediaItemSeason(episodes: [
              MediaItemEpisode(
                  videoFileUrl:
                      src.replaceAll('index.m3u8', 'tracks-v1/mono.m3u8'))
            ])
          ];

          items.add(MediaItem(
            type: MediaItemType.movie,
            id: id,
            title: title,
            poster: '${_dio.options.baseUrl}$preview',
            seasons: seasons,
          ));
        }

        return items;
      },
    );
  }
}
