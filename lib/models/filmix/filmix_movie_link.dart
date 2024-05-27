import 'package:freezed_annotation/freezed_annotation.dart';

part 'filmix_movie_link.g.dart';

@JsonSerializable(explicitToJson: true)
class FilmixMovieLink {
  final String link;
  final String translation;

  const FilmixMovieLink({
    this.link = '',
    this.translation = '',
  });

  factory FilmixMovieLink.fromJson(Map<String, dynamic> json) =>
      _$FilmixMovieLinkFromJson(json);

  Map<String, dynamic> toJson() => _$FilmixMovieLinkToJson(this);
}
