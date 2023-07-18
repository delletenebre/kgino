import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:isar/isar.dart';
import 'package:kgino/resources/krs_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/api_response.dart';
import '../models/device_details.dart';
import '../models/episode_item.dart';
import '../models/flmx/flmx_item.dart';
import '../models/flmx/flmx_profile.dart';
import '../models/flmx/flmx_token.dart';
import '../models/kgino_item.dart';
import '../models/season_item.dart';
import '../models/voice_acting.dart';
import 'api_request.dart';
import 'logs_interceptor.dart';

class HdrzApiProvider {

  /// cinema online
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://hdrzk.org',
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

        /// парсим постер
        final posterUrl = document.getElementsByClassName('b-sidecover')
          .firstOrNull?.getElementsByTagName('a')
          .firstOrNull?.attributes['href'] ?? '';
        
        /// парсим название фильма
        final movieName = document.getElementsByClassName('b-post__title')
          .firstOrNull?.getElementsByTagName('h1')
          .firstOrNull?.text ?? '';

        /// парсим оригинальное название фильма
        final originalName = document.getElementsByClassName('b-post__origtitle')
          .firstOrNull?.text ?? '';


        /// парсим описание фильма
        final description = document.getElementsByClassName('b-post__description_text')
          .firstOrNull?.text ?? '';

        /// рейтинг IMDb
        double imdbRating = 0.0;

        /// рейтинг Kinopoisk
        double kinopoiskRating = 0.0;

        /// год выхода
        String year = '';

        /// страны
        List<String> countries = [];

        /// жанры
        List<String> genres = [];

        /// продолжительность
        Duration duration = Duration.zero;


        /// сезоны
        List<SeasonItem> seasons = [];

        Map<String, VoiceActing> voiceActings = {};
        Map<String, List<SeasonItem>> voiceActingSeasons = {};

        /// парсим переводы
        final translatorsList = document.getElementById('translators-list')
          ?.getElementsByTagName('li').map((e) {
            return VoiceActing(
              id: e.attributes['data-translator_id'] ?? '',
              name: e.text,
            );
          }).toList() ?? [];
        final voiceActing = translatorsList.firstOrNull?.name ?? '';

        final postInfoTable = document.getElementsByClassName('b-post__info')
          .firstOrNull?.getElementsByTagName('tr') ?? [];
        
        for (final Element tr in postInfoTable) {
          final section = tr.getElementsByClassName('l')
            .firstOrNull?.getElementsByTagName('h2')
            .firstOrNull?.text ?? '';

          if (section == 'Рейтинги') {
            /// парсим рейтинг IMDb
            imdbRating = double.tryParse(
              tr.getElementsByClassName('b-post__info_rates imdb')
              .firstOrNull?.getElementsByClassName('bold')
              .firstOrNull?.text ?? '0.0'
            ) ?? 0.0;

            /// парсим рейтинг Kinopoisk
            kinopoiskRating = double.tryParse(
              tr.getElementsByClassName('b-post__info_rates kp')
              .firstOrNull?.getElementsByClassName('bold')
              .firstOrNull?.text ?? '0.0'
            ) ?? 0.0;

          } else if (section == 'Дата выхода') {
            /// парсим год выхода
            final yearHref = tr.getElementsByTagName('a')
              .firstOrNull?.attributes['href']?.split('/');
            yearHref?.removeLast();
            year = yearHref?.lastOrNull ?? '';
            
          } else if (section == 'Страна') {
            /// парсим страны
            countries = tr.getElementsByTagName('a').map((e) => e.text).toList();
            
          } else if (section == 'Жанр') {
            /// парсим жанры
            genres = tr.getElementsByTagName('span').map((e) => e.text).toList();
            
          } else if (section == 'Время') {
            /// парсим продолжительность
            final durationMinutes = int.tryParse(tr.getElementsByTagName('td')
              .lastOrNull?.text.split(' ')
              .firstOrNull ?? '0') ?? 0;
            duration = Duration(minutes: durationMinutes);

          }

        }

        // voiceActings[movie.translation] = VoiceActing(
        //   id: movie.translation,
        //   name: movie.translation,
        //   seasons: [
        //     SeasonItem(
        //       episodes: [
        //         EpisodeItem(
        //           id: '0/0',
        //           fullId: EpisodeItem.getFullId(provider.name, id.toString(), '0/0'),
        //           playableQualities: playableQualities,
        //           videoFileUrl: videoUrl,
        //           duration: duration,
        //         ),
        //       ],
        //     )
        //   ],
        // );
        
        final movieId = document.getElementById('send-video-issue')?.attributes['data-id'] ?? '';

        return KginoItem(
          provider: KginoProvider.hdrz.name,
          id: movieId,
          name: movieName,
          posterUrl: posterUrl,
          seasons: [
            SeasonItem(
              episodes: [
                EpisodeItem(
                  id: '0/0',
                  fullId: EpisodeItem.getFullId(KginoProvider.hdrz.name, id.toString(), '0/0'),
                ),
              ],
            ),
          ],

          description: description.trim(),
          originalName: originalName,
          year: year.toString(),
          countries: countries,
          genres: genres,
          imdbRating: imdbRating,
          kinopoiskRating: kinopoiskRating,
          duration: duration,
          voiceActings: {
            for (final v in translatorsList)
              v.name : v
          },
          voiceActing: voiceActing,
        );
      },
    );
  }

}
