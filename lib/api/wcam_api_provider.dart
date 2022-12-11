import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/episode_item.dart';
import '../models/movie_item.dart';
import '../models/season_item.dart';

class WcamApiProvider {

  /// ts.kg
  // final _elcatDio = Dio(BaseOptions(
  //   baseUrl: 'https://www.ts.kg',
  //   sendTimeout: requestTimeout.inMilliseconds,
  //   receiveTimeout: requestTimeout.inMilliseconds,
  //   headers: {
  //     'User-Agent': userAgent,
  //   },
  // ));

  static String getTextByClassName(Document document, String className) {
    final elements = document.getElementsByClassName(className);
    if (elements.isNotEmpty) {
      return elements.first.text.trim();
    }

    return '';
  }

  /// получение списка камер elcat.kg
  Future<List<MovieItem>> getElcatCameras() async {
    
    /// список элементов
    final items = <MovieItem>[];

    try {

      /// запрашиваем данные
      final response = await Dio().get('https://elcat.kg/translation');

      if (response.statusCode == 200) {
        /// ^ если запрос выполнен успешно
        /// парсим html
        final document = parse(response.data);

        

        
        /// получаем элементы списка камер
        final elements = document.getElementsByClassName('stream_hide');

        return elements.map((element) {
          /// парсим элемент iframe
          /*
            <iframe width="560" height="315" src="//webcam.elcat.kg:5443/LiveApp/play.html?name=328712567719434766950272&autoplay=true" frameborder="0" allowfullscreen></iframe>
          */
          String streamName = '';
          final src = element.getElementsByTagName('iframe').first.attributes['src'];
          final uri = Uri.parse(src ?? '');
          if (uri.hasQuery) {
            streamName = uri.queryParameters['name'] ?? '';
          }


          /// парсим элемент с названием
          /*
            <div id="video_3" class="tranlation__item">
              <img src="https://elcat.kg/wp-content/uploads/2019/11/Въезд-в-Балыкчи.jpeg">
              <h2>Въезд в г. Балыкчи</h2>
              <span></span>
            </div>
          */
          final translation = element.nextElementSibling;
          final imageSrc = translation?.getElementsByTagName('img').first.attributes['src'] ?? '';
          final name = translation?.getElementsByTagName('h2').first.text ?? '';

          return MovieItem(
            type: MovieItemType.wcam,
            id: streamName,
            name: name,
            posterUrl: imageSrc,
            seasons: [
              SeasonItem(
                name: '',
                episodes: [
                  EpisodeItem(
                    id: '',
                    name: '',
                    videoFileUrl: 'https://webcam.elcat.kg:5443/LiveApp/streams/$streamName.m3u8?token=null'
                  ),
                ]
              )
            ]
          );

        }).toList();

        

      }
    } catch (exception, stack) {
      /// ^ если прозошла сетевая ошибка
      
      debugPrint('exception: $exception');
    }

    return items;
  }

  Future<List<MovieItem>> getKtCameras() async {
    return [
      MovieItem(
        type: MovieItemType.wcam,
        id: '1',
        name: 'г. Бишкек (Чуй/Советская)',
        posterUrl: '',
        seasons: [
          SeasonItem(
            name: '',
            episodes: [
              EpisodeItem(
                id: '',
                name: '',
                videoFileUrl: 'http://213.145.131.243:80/cam1/stream.m3u8'
              ),
            ],
          ),
        ],
      ),
      MovieItem(
        type: MovieItemType.wcam,
        id: '2',
        name: 'с. Бостери',
        posterUrl: '',
        seasons: [
          SeasonItem(
            name: '',
            episodes: [
              EpisodeItem(
                id: '',
                name: '',
                videoFileUrl: 'http://213.145.131.243:80/cam2/stream.m3u8'
              ),
            ],
          ),
        ],
      ),
      MovieItem(
        type: MovieItemType.wcam,
        id: '3',
        name: 'г. Ош',
        posterUrl: '',
        seasons: [
          SeasonItem(
            name: '',
            episodes: [
              EpisodeItem(
                id: '',
                name: '',
                videoFileUrl: 'http://213.145.131.243:80/cam3/stream.m3u8'
              ),
            ],
          ),
        ],
      ),
      
      
    ];
  }

}
