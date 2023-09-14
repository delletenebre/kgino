import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'media_item.dart';

part 'tmdb_movie.freezed.dart';
part 'tmdb_movie.g.dart';

@freezed
class TmdbMovie with _$TmdbMovie {
  const TmdbMovie._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TmdbMovie({
    @Default('') String name,
    @Default('') String overview,
    @Default('') String backdropPath,
    @Default('') String posterPath,
  }) = _TmdbMovie;

  factory TmdbMovie.fromJson(Map<String, Object?> json) =>
      _$TmdbMovieFromJson(json);

  String get backdropImage => 'https://image.tmdb.org/t/p/w500$backdropPath';

  MediaItem toMediaItem() {
    return MediaItem(
      title: name,
      backdropUrl: backdropImage,
      overview: overview,
    );
  }
}
