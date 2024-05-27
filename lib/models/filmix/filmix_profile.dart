import 'package:freezed_annotation/freezed_annotation.dart';

part 'filmix_profile.freezed.dart';
part 'filmix_profile.g.dart';

@freezed
class FilmixProfile with _$FilmixProfile {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FilmixProfile({
    required FilmixProfileData userData,
  }) = _FilmixProfile;

  factory FilmixProfile.fromJson(Map<String, Object?> json) =>
      _$FilmixProfileFromJson(json);
}

@freezed
class FilmixProfileData with _$FilmixProfileData {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FilmixProfileData({
    @Default('') String login,
    @Default(false) bool isPro,
    @Default(false) bool isProPlus,
    @Default('') String displayName,
    @Default('') String videoserver,
  }) = _FilmixProfileData;

  factory FilmixProfileData.fromJson(Map<String, Object?> json) =>
      _$FilmixProfileDataFromJson(json);
}
