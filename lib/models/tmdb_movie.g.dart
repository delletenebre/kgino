// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TmdbMovie _$$_TmdbMovieFromJson(Map<String, dynamic> json) => _$_TmdbMovie(
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
    );

Map<String, dynamic> _$$_TmdbMovieToJson(_$_TmdbMovie instance) =>
    <String, dynamic>{
      'name': instance.name,
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
    };
