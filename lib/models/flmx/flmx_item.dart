import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kgino/models/episode_item.dart';

import '../json_converters.dart';
import '../kgino_item.dart';
import '../season_item.dart';
import '../voice_acting.dart';
import 'flmx_last_episode.dart';
import 'flmx_player_links.dart';
import 'flmx_show_link.dart';

part 'flmx_item.freezed.dart';
part 'flmx_item.g.dart';

@freezed
class FlmxItem with _$FlmxItem {
  const FlmxItem._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FlmxItem({
    @IntConverter() @Default(0) int id,
    @IntConverter() @Default(0) int section,
    @IntConverter() @Default(0) int year,
    @IntConverter() @Default(0) int yearEnd,
    @IntConverter() @Default(0) int duration,
    @Default('') String poster,
    @Default('') String title,
    @Default('') String originalTitle,
    DateTime? dateAtom,
    @Default(false) bool favorited,
    @Default(false) bool watchLater,
    @HtmlRemoveConverter() @Default('') String shortStory,
    @Default('') String rip,
    @Default('') String quality,
    @Default([]) List<String> categories,
    @Default([]) List<String> actors,
    @Default([]) List<String> directors,
    @Default([]) List<String> countries,

    @DoubleConverter() @Default(0.0) double kpRating,
    @DoubleConverter() @Default(0.0) double imdbRating,

    @Default(FlmxPlayerLinks()) FlmxPlayerLinks playerLinks,

    FlmxLastEpisode? lastEpisode,
    
  }) = _FlmxItem;

  factory FlmxItem.fromJson(Map<String, Object?> json)
      => _$FlmxItemFromJson(json);

  KginoItem toMovieItem() {
    /// сезоны
    List<SeasonItem> seasons = [];

    KginoProvider provider = KginoProvider.flmxMovie;

    String voiceActing = '';
    Map<String, VoiceActing> voiceActings = {};
    Map<String, List<SeasonItem>> voiceActingSeasons = {};

    if (playerLinks.movie.isNotEmpty) {
      /// ^ если это фильм
      
      for (final movie in playerLinks.movie) {
        final playableQualities = <int>[];

        final qualityRegExp = RegExp(r'\[([,\d]+)\]');
        final qualities = qualityRegExp.allMatches(movie.link)
          .map((m) => m.group(0));
        
        if (qualities.isNotEmpty) {
          final variants = qualities.first.toString().split(',');
          variants.removeWhere((element) => int.tryParse(element) == null);
          playableQualities.addAll(variants.map((v) => int.tryParse(v) ?? 0));
        }
        
        final videoUrl = movie.link.replaceFirst(RegExp(r'(\[[,\d]+\])'), '%s');

        voiceActings[movie.translation] = VoiceActing(
          id: movie.translation,
          name: movie.translation,
          seasons: [
            SeasonItem(
              episodes: [
                EpisodeItem(
                  id: '0/0',
                  fullId: EpisodeItem.getFullId(provider.name, id.toString(), '0/0'),
                  playableQualities: playableQualities,
                  videoFileUrl: videoUrl,
                  duration: duration,
                ),
              ],
            )
          ],
        );

      }

      voiceActing = playerLinks.movie.first.translation;
      seasons = voiceActings[voiceActing]!.seasons;
    }

    /// playlist as Map<String, Map<String, Map<String, FlmxShowLink>>>
    if (playerLinks.playlist is Map && playerLinks.playlist.isNotEmpty) {
      /// ^ если это сериал
      
      provider = KginoProvider.flmxShow;
      /// парсим как [Map<String, Map<String, Map<String, FlmxShowLink>>>]
      // final playlist = (playerLinks.playlist as Map<String, dynamic>).map(
      //   (k, e) => MapEntry(
      //     k, (e as Map<String, dynamic>).map(
      //       (k, e) => MapEntry(
      //         k, (e as Map<String, dynamic>).map(
      //           (k, e) => MapEntry(k,
      //               FlmxShowLink.fromJson(e as Map<String, dynamic>)),
      //         )),
      //     )),
      // );

      final playlist = (playerLinks.playlist as Map<String, dynamic>).map(
        (k, e) {
          // print('k $k');
          return MapEntry(
            k, (e as Map<String, dynamic>).map(
              (k, e) {
                // print('kkk $k');

                try {
                  return MapEntry(
                    k, (e as Map<String, dynamic>).map(
                      (k, e) {
                        // print('kkkkk $k');
                        return MapEntry(k, FlmxShowLink.fromJson(e as Map<String, dynamic>));
                      }
                    )
                  );
                } catch (exception) {
                  return const MapEntry('', <String, FlmxShowLink>{});
                }
              }
            )
          );
        },
      );
    
      /// список всех доступных озвучек
      final translationsMap = <String, Map<String, Map<String, FlmxShowLink>>>{};

      for (final seasonNumber in playlist.keys) {
        
        /// сезон со всеми вариантами озвучек
        final translationMap = playlist[seasonNumber]!;

        /// если были проблемы с парсингом, удаляем пустую озвучку
        translationMap.remove('');
        
        for (final translationName in translationMap.keys) {

          /// добавляем вариант озвучки в общий список, если его ещё нет
          translationsMap.putIfAbsent(translationName, () => {});

          /// эпизоды сезона текущим вариантом озвучки
          final episodes = translationMap[translationName]!;

          /// добавляем эпизоды сезона
          translationsMap[translationName]![seasonNumber] = episodes;
        }
      }
      
      for (final entry in translationsMap.entries) {
        final translationName = entry.key;
        final seasonsMap = entry.value;

        /// список сезонов
        final seasons = <SeasonItem>[];

        /// формируем список сезонов
        for (final seasonEntry in seasonsMap.entries) {
          final seasonNumber = seasonEntry.key;
          final episodesMap = seasonEntry.value;

          /// список эпизодов
          final episodes = <EpisodeItem>[];
          
          /// формируем список эпизодов сезона
          for (final episodeEntry in episodesMap.entries) {
            final episodeNumber = episodeEntry.key;
            final episodeValue = episodeEntry.value;

            final episodeId = '$seasonNumber/$episodeNumber';
            
            /// формируем эпизод
            episodes.add(
              EpisodeItem(
                id: episodeId,
                fullId: EpisodeItem.getFullId(provider.name, id.toString(), episodeId),
                name: episodeNumber,
                seasonNumber: int.tryParse(seasonNumber) ?? 0,
                episodeNumber: int.tryParse(episodeNumber) ?? 0,
                videoFileUrl: episodeValue.link,
                playableQualities: episodeValue.qualities,
              ),
            );
          }

          /// формируем сезон   
          seasons.add(
            SeasonItem(
              name: seasonNumber,
              episodes: episodes,
            )
          );

          voiceActingSeasons[translationName] = seasons;
        }
        
        voiceActings[translationName] = VoiceActing(
          id: translationName,
          name: translationName,
          seasons: voiceActingSeasons[translationName]!,
        );
      }

      /// первый вариант озвучки
      voiceActing = translationsMap.keys.first;
      seasons = voiceActingSeasons[voiceActing]!;
    }
    
    
    return KginoItem(
      provider: provider.name,
      id: id.toString(),
      name: title,
      originalName: originalTitle,
      posterUrl: poster,
      description: shortStory,
      year: year.toString(),
      genres: categories,
      countries: countries,

      imdbRating: imdbRating,
      kinopoiskRating: kpRating,

      duration: Duration(minutes: duration),

      voiceActing: voiceActing,
      voiceActings: voiceActings,

      seasons: seasons,
    );
  }
  
}
