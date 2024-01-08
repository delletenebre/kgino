import 'package:freezed_annotation/freezed_annotation.dart';

part 'filmix_token.freezed.dart';
part 'filmix_token.g.dart';

@freezed
class FilmixToken with _$FilmixToken {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FilmixToken({
    @Default('') String code,
    @Default('') String userCode,
    @Default(0) int expire,
  }) = _FilmixToken;

  factory FilmixToken.fromJson(Map<String, Object?> json) =>
      _$FilmixTokenFromJson(json);
}
