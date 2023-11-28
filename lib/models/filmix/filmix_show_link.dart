import 'package:freezed_annotation/freezed_annotation.dart';

part 'filmix_show_link.freezed.dart';
part 'filmix_show_link.g.dart';

@freezed
class FilmixShowLink with _$FilmixShowLink {
  const factory FilmixShowLink({
    @Default('') String link,
    @Default([]) List<int> qualities,
  }) = _FilmixShowLink;

  factory FilmixShowLink.fromJson(Map<String, Object?> json) =>
      _$FilmixShowLinkFromJson(json);
}
