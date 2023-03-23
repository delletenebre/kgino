import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kgino/models/episode_item.dart';

import '../json_converters.dart';
import '../kgino_item.dart';
import '../season_item.dart';
import 'flmx_player_links.dart';

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
    
  }) = _FlmxItem;

  factory FlmxItem.fromJson(Map<String, Object?> json)
      => _$FlmxItemFromJson(json);

  KginoItem toMovieItem() {
    /// сезоны
    List<SeasonItem> seasons = [];

    String voiceActing = '';
    List<KginoItem> voiceActings = [];
    List<String> voiceActingsvoiceActingIds = [];

    if (playerLinks.movie.isNotEmpty) {
      if (playerLinks.movie.length > 1) {
        /// ^ если есть разные озвучки
      
        voiceActings = playerLinks.movie.map((movie) {
          final seasons = [
            SeasonItem(
              name: '',
              episodes: [
                EpisodeItem(
                  id: movie.link,
                  name: '',
                  updatedAt: DateTime.now(),
                ),
              ]
            )
          ];
          
          return KginoItem(
            type: KginoItemType.movie,
            provider: KginoProvider.flmx,
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

            voiceActing: movie.translation,
            voiceActings: voiceActings,

            seasons: seasons,

            updatedAt: DateTime.now(),
          );
        }).toList();
      }

      voiceActing = playerLinks.movie.first.translation;

      seasons = [
        SeasonItem(
          name: '',
          episodes: [
            EpisodeItem(
              id: playerLinks.movie.first.link,
              name: '',
              updatedAt: DateTime.now(),
            ),
          ]
        )
      ];
    }

    return KginoItem(
      type: KginoItemType.movie,
      provider: KginoProvider.flmx,
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

      updatedAt: DateTime.now(),
    );
  }
  
}
