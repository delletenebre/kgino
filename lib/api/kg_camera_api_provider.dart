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

  /// список камер elcat
  Future<List<MediaItem>> getElcatCameras() async {
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

          final seasons = [
            MediaItemSeason(episodes: [
              MediaItemEpisode(videoFileUrl: src),
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

  /// получение списка камер live.saimanet.kg
  Future<List<MediaItem>> getSaimaCameras() async {
    const baseUrl = 'https://live.saimanet.kg';

    return ApiRequest<List<MediaItem>>().call(
        request: _dio.get(baseUrl),
        decoder: (response) async {
          /// список элементов
          final items = <MediaItem>[];

          /// запрашиваем данные
          final response = await _dio.get(baseUrl);

          if (response.statusCode == 200) {
            /// ^ если запрос выполнен успешно

            /// парсим html
            final document = parse(response.data);

            /// получаем элементы списка камер
            final elements = document.getElementsByClassName('onemaincam');

            for (final element in elements) {
              /// парсим элемент iframe
              /*
                <div class="onemaincam mt">
                  <div class="image">
                      <a href="/ru/cams/2"><img src="/images/cam2.jpg"
                                                alt=""
                                                title=""/></a>
                      <div class="playicon"><a href="/ru/cams/2"></a></div>
                  </div>
                  <div class="title"><a href="/ru/cams/2">Площадь Ала-Тоо</a></div>
                </div>
              */
              String name = '';
              String posterUrl = '';
              final img = element.getElementsByTagName('img');
              if (img.isNotEmpty) {
                String imgSrc = img.first.attributes['src'] ?? '';
                if (!imgSrc.startsWith('/')) {
                  imgSrc = '/$imgSrc';
                }
                posterUrl = '$baseUrl$imgSrc';
              }

              final link = element
                  .getElementsByClassName('title')
                  .first
                  .getElementsByTagName('a');
              if (link.isNotEmpty) {
                name = link.first.text;
                final cameraId = link.first.attributes['href'] ?? '';
                final youtubeSrc =
                    await getSaimaYoutubeLink(baseUrl + cameraId);

                if (youtubeSrc.isNotEmpty) {
                  final seasons = [
                    MediaItemSeason(episodes: [
                      MediaItemEpisode(videoFileUrl: youtubeSrc),
                    ])
                  ];

                  items.add(MediaItem(
                    type: MediaItemType.movie,
                    title: name,
                    poster: posterUrl,
                    seasons: seasons,
                  ));
                }
              }
            }
          }
          return items;
        });
  }

  Future<String> getSaimaYoutubeLink(String url) async {
    try {
      /// запрашиваем данные
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно

        /// парсим html
        final document = parse(response.data);
        final iframe = document.getElementsByTagName('iframe').first;

        return iframe.attributes['src'] ?? '';
      }
    } catch (exception) {
      /// ^ если произошла сетевая ошибка
    }

    return '';
  }
}
