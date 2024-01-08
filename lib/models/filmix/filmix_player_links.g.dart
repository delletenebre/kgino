// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_player_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmixPlayerLinks _$FilmixPlayerLinksFromJson(Map<String, dynamic> json) =>
    FilmixPlayerLinks(
      movie: (json['movie'] as List<dynamic>?)
              ?.map((e) => FilmixMovieLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      playlist: json['playlist'],
    );

Map<String, dynamic> _$FilmixPlayerLinksToJson(FilmixPlayerLinks instance) =>
    <String, dynamic>{
      'movie': instance.movie.map((e) => e.toJson()).toList(),
      'playlist': instance.playlist,
    };
