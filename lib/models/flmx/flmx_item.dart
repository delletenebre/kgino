import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';
import '../movie_item.dart';

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
    
  }) = _FlmxItem;

  factory FlmxItem.fromJson(Map<String, Object?> json)
      => _$FlmxItemFromJson(json);

  MovieItem toMovieItem() {
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
    );
  }
  
}
