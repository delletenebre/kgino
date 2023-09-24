import 'package:freezed_annotation/freezed_annotation.dart';

part 'filmix_movie_link.freezed.dart';
part 'filmix_movie_link.g.dart';

@freezed
class FilmixMovieLink with _$FilmixMovieLink {
  const factory FilmixMovieLink({
    @Default('') String link,
    @Default('') String translation,
  }) = _FilmixMovieLink;

  factory FilmixMovieLink.fromJson(Map<String, Object?> json) =>
      _$FilmixMovieLinkFromJson(json);
}
