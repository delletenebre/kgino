// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_player_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FilmixPlayerLinks _$$_FilmixPlayerLinksFromJson(Map<String, dynamic> json) =>
    _$_FilmixPlayerLinks(
      movie: (json['movie'] as List<dynamic>?)
              ?.map((e) => FilmixMovieLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      playlist: json['playlist'],
    );

Map<String, dynamic> _$$_FilmixPlayerLinksToJson(
        _$_FilmixPlayerLinks instance) =>
    <String, dynamic>{
      'movie': instance.movie,
      'playlist': instance.playlist,
    };
