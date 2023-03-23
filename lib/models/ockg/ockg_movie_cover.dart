import 'package:freezed_annotation/freezed_annotation.dart';

part 'ockg_movie_cover.freezed.dart';
part 'ockg_movie_cover.g.dart';

@freezed
class OckgMovieCover with _$OckgMovieCover {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgMovieCover({
    @Default('') String original,
    
    @Default('') String thumbnail,

  }) = _OckgMovieCover;

  factory OckgMovieCover.fromJson(Map<String, Object?> json)
      => _$OckgMovieCoverFromJson(json);
}
