import 'package:freezed_annotation/freezed_annotation.dart';

part 'flmx_token.freezed.dart';
part 'flmx_token.g.dart';

@freezed
class FlmxToken with _$FlmxToken {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FlmxToken({
    @Default('') String code,
    @Default('') String userCode,
    @Default(0) int expire,
  }) = _FlmxToken;

  factory FlmxToken.fromJson(Map<String, Object?> json)
      => _$FlmxTokenFromJson(json);
}
