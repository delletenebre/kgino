import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kgino/models/episode_item.dart';

import '../json_converters.dart';
import '../movie_item.dart';
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

  MovieItem toMovieItem() {
    /// сезоны
    List<SeasonItem> seasons = [];

    String voiceActing = '';
    List<String> voiceActingIds = [];

    if (playerLinks.movie.isNotEmpty) {
      voiceActing = playerLinks.movie.first.translation;
      voiceActingIds = playerLinks.movie.map((e) => e.translation).toList();

      seasons = [
        SeasonItem(
          name: '',
          episodes: [
            EpisodeItem(
              id: playerLinks.movie.first.link,
              name: '',
            ),
          ]
        )
      ];
    }

    

    return MovieItem(
      type: MovieItemType.flmx,
      id: id.toString(),
      name: title,
      originalName: originalTitle,
      posterUrl: poster,
      description: shortStory,
      year: year.toString(),
      genres: categories,
      countries: countries,

      ratingImdb: imdbRating,
      ratingKinopoisk: kpRating,

      duration: Duration(minutes: duration),

      voiceActing: voiceActing,
      voiceActingIds: voiceActingIds,

      seasons: seasons,
    );
  }
  
}
