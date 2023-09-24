import 'package:freezed_annotation/freezed_annotation.dart';

import 'filmix_movie_link.dart';

part 'filmix_player_links.freezed.dart';
part 'filmix_player_links.g.dart';

@freezed
class FilmixPlayerLinks with _$FilmixPlayerLinks {
  const factory FilmixPlayerLinks({
    @Default([]) List<FilmixMovieLink> movie,
    dynamic playlist,
    //@Default([]) List<FlmxMovieLink> trailer,
  }) = _FilmixPlayerLinks;

  factory FilmixPlayerLinks.fromJson(Map<String, Object?> json) =>
      _$FilmixPlayerLinksFromJson(json);
}
