import 'package:freezed_annotation/freezed_annotation.dart';

part 'ockg_movie.freezed.dart';
part 'ockg_movie.g.dart';

@freezed
class OckgMovie with _$OckgMovie {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgMovie({
    @Default('') String movieId,
    @Default('') String name,
    @Default('') String internationalName,
    @Default('') String year,
    @Default('') String cover,
  }) = _OckgMovie;

  factory OckgMovie.fromJson(Map<String, Object?> json)
      => _$OckgMovieFromJson(json);
}