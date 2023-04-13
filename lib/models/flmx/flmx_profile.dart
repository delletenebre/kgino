import 'package:freezed_annotation/freezed_annotation.dart';

part 'flmx_profile.freezed.dart';
part 'flmx_profile.g.dart';

@freezed
class FlmxProfile with _$FlmxProfile {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FlmxProfile({
    required FlmxProfileData userData,
  }) = _FlmxProfile;

  factory FlmxProfile.fromJson(Map<String, Object?> json)
      => _$FlmxProfileFromJson(json);
}


@freezed
class FlmxProfileData with _$FlmxProfileData {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FlmxProfileData({
    @Default('') String login,
    @Default(false) bool isPro,
    @Default(false) bool isProPlus,
    @Default('') String displayName,
    @Default('') String videoserver,
  }) = _FlmxProfileData;

  factory FlmxProfileData.fromJson(Map<String, Object?> json)
      => _$FlmxProfileDataFromJson(json);
}
