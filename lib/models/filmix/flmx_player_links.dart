import 'package:freezed_annotation/freezed_annotation.dart';

import 'flmx_movie_link.dart';

part 'flmx_player_links.freezed.dart';
part 'flmx_player_links.g.dart';

@freezed
class FlmxPlayerLinks with _$FlmxPlayerLinks {
  const factory FlmxPlayerLinks({
    @Default([]) List<FlmxMovieLink> movie,
    dynamic playlist,
    //@Default([]) List<FlmxMovieLink> trailer,
  }) = _FlmxPlayerLinks;

  factory FlmxPlayerLinks.fromJson(Map<String, Object?> json)
      => _$FlmxPlayerLinksFromJson(json);
  
}
