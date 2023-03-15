import 'package:freezed_annotation/freezed_annotation.dart';

part 'flmx_movie_link.freezed.dart';
part 'flmx_movie_link.g.dart';

@freezed
class FlmxMovieLink with _$FlmxMovieLink {
  const factory FlmxMovieLink({
    @Default('') String link,
    @Default('') String translation,
  }) = _FlmxMovieLink;

  factory FlmxMovieLink.fromJson(Map<String, Object?> json)
      => _$FlmxMovieLinkFromJson(json);
}
