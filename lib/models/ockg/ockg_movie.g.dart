// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgMovie _$$_OckgMovieFromJson(Map<String, dynamic> json) => _$_OckgMovie(
      movieId: json['movie_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      internationalName: json['international_name'] as String? ?? '',
      year: json['year'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
    );

Map<String, dynamic> _$$_OckgMovieToJson(_$_OckgMovie instance) =>
    <String, dynamic>{
      'movie_id': instance.movieId,
      'name': instance.name,
      'international_name': instance.internationalName,
      'year': instance.year,
      'cover': instance.cover,
    };
