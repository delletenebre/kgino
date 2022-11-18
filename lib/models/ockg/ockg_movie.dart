import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'ockg_movie.freezed.dart';
part 'ockg_movie.g.dart';

@freezed
class OckgMovie with _$OckgMovie {
  const OckgMovie._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgMovie({
    @IntConverter()
    @Default(0) int movieId,
    @Default('') String name,
    @Default('') String internationalName,
    @Default('') String year,
    @Default('') String cover,

    @HtmlRemoveConverter()
    @Default('') String description,
    @Default([]) List<String> translation,
    @Default('') String quality,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<String> genres,
    @Default([]) List<String> countries,
    @Default([]) List<String> directors,
    
    // @DoubleConverter()
    // @Default(0.0) double ratingLocalValue,

    @DoubleConverter()
    @Default(0.0) double ratingImdbValue,

    @DoubleConverter()
    @Default(0.0) double ratingKinopoiskValue,

    @Default([]) List<OckgMovie> otherMovies,

  }) = _OckgMovie;

  factory OckgMovie.fromJson(Map<String, Object?> json)
      => _$OckgMovieFromJson(json);

  String get coverUrl => 'https://oc.kg$cover';
  
}
