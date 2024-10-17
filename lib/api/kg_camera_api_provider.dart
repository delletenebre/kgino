import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      // _dio.interceptors.add(LogInterceptor(responseBody: true));
    }
  }

  /// список камер elcat
  Future<List<MediaItem>> getElcatCameras() async {
    const baseUrl = 'https://kg.camera';

    return ApiRequest<List<MediaItem>>().call(
      request:
          _dio.get('$baseUrl/', queryParameters: {'t': DateTime.now().minute}),
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
              MediaItemEpisode(videoFileUrl: src, isLiveStream: true),
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
                      MediaItemEpisode(
                        videoFileUrl: youtubeSrc,
                        isLiveStream: true,
                      ),
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

  /// список камер КыргызТелеком
  Future<List<MediaItem>> getKtCameras() async {
    const baseUrl = 'https://online.kt.kg';
    return ApiRequest<List<MediaItem>>().call(
      request: Dio().get(baseUrl),
      decoder: (response) async {
        final html = response.toString();

        final items = <MediaItem>[];

        /// парсим html
        final document = parse(html);

        /// получаем элементы списка новых поступлений
        final elements = document.getElementsByClassName('button');

        for (final element in elements) {
          /// <button style="background: #282828;" class="button" id="camera_0" onclick="change_source('https://cam.kt.kg/cam14/stream.m3u8', 'Бишкек', 'Bishkek,KG', 'camera_0')">
          ///     <img class="img" src="/preview/%D0%91%D0%B8%D1%88%D0%BA%D0%B5%D0%BA" style="border-radius: 10px; margin-right: max(10px, 2vh);"> Бишкек
          /// </button>

          /// парсим идентификатор
          final onClick = element.attributes['onclick'] ?? '';

          if (onClick.isNotEmpty) {
            final exp = RegExp(r"'(.+?)'");
            final matches = exp.allMatches(onClick);

            if (matches.isNotEmpty) {
              final src = matches.elementAt(0).group(1) ?? '';

              final preview = element
                  .getElementsByTagName('img')
                  .firstOrNull
                  ?.attributes['src'];

              final title = matches.elementAt(1).group(1) ?? '';

              final seasons = [
                MediaItemSeason(episodes: [
                  MediaItemEpisode(videoFileUrl: src, isLiveStream: true),
                ])
              ];

              items.add(MediaItem(
                type: MediaItemType.movie,
                title: title,
                poster: '$baseUrl$preview',
                seasons: seasons,
              ));
            }
          }
        }

        return items;
      },
    );
  }

  /// список камер интересных мест
  List<MediaItem> getExtraCameras() => [
        MediaItem(
          type: MediaItemType.folder,
          title: 'Кенийский водопой',
          poster: 'https://i.ytimg.com/vi/KyQAB-TKOVA/hqdefault_live.jpg',
          seasons: [
            MediaItemSeason(episodes: [
              MediaItemEpisode(
                videoFileUrl: 'https://www.youtube.com/watch?v=KyQAB-TKOVA',
                isLiveStream: true,
              ),
            ])
          ],
        ),
        MediaItem(
          type: MediaItemType.folder,
          title: 'Африканские животные',
          poster: 'https://i.ytimg.com/vi/O8xVFhgEv6Q/hqdefault_live.jpg',
          seasons: [
            MediaItemSeason(episodes: [
              MediaItemEpisode(
                videoFileUrl: 'https://www.youtube.com/watch?v=O8xVFhgEv6Q',
                isLiveStream: true,
              ),
            ])
          ],
        ),
        MediaItem(
          type: MediaItemType.folder,
          title: 'Сафари камера',
          poster: 'https://i.ytimg.com/vi/QkWGGhtTA4k/hqdefault_live.jpg',
          seasons: [
            MediaItemSeason(episodes: [
              MediaItemEpisode(
                videoFileUrl: 'https://www.youtube.com/watch?v=QkWGGhtTA4k',
                isLiveStream: true,
              ),
            ])
          ],
        ),
        MediaItem(
          type: MediaItemType.folder,
          title: 'Парк слонов',
          poster: 'https://i.ytimg.com/vi/VUJbDTIYlM4/hqdefault_live.jpg',
          seasons: [
            MediaItemSeason(episodes: [
              MediaItemEpisode(
                videoFileUrl: 'https://www.youtube.com/watch?v=VUJbDTIYlM4',
                isLiveStream: true,
              ),
            ])
          ],
        ),
      ];
}
