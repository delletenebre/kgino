import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:palette_generator/palette_generator.dart';

import '../json_converters.dart';
import 'ockg_file.dart';
import 'ockg_movie_cover.dart';

part 'ockg_movie.freezed.dart';
part 'ockg_movie.g.dart';

@freezed
class OckgMovie with _$OckgMovie {
  static const baseUrl = 'https://oc.kg';

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
    @Default([]) List<OckgMovieCover> covers,

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

    @Default([]) List<OckgFile> files,

    @Default([]) List<OckgMovie> otherMovies,

  }) = _OckgMovie;

  factory OckgMovie.fromJson(Map<String, Object?> json)
      => _$OckgMovieFromJson(json);

  String get coverUrl => (cover.isNotEmpty)
      ? '$baseUrl$cover'
      : '$baseUrl${covers.first.thumbnail}';

  String get posterUrl => (covers.isNotEmpty)
      ? '$baseUrl${covers.first.original}'
      : '$baseUrl$cover';

  Duration get playtimeDuration => Duration(
    seconds: files.fold(0, (previousValue, file) {
      return previousValue + file.metainfo.playtimeSeconds;
    })
  );

  Future<PaletteGenerator> getPaletteGenerator(String imageUrl) async {
    return PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl)
    );
  }
  
}
