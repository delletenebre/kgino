// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgMovie _$$_OckgMovieFromJson(Map<String, dynamic> json) => _$_OckgMovie(
      movieId: json['movie_id'] == null
          ? 0
          : const IntConverter().fromJson(json['movie_id']),
      name: json['name'] as String? ?? '',
      internationalName: json['international_name'] as String? ?? '',
      year: json['year'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      description: json['description'] == null
          ? ''
          : const HtmlRemoveConverter().fromJson(json['description'] as String),
      translation: (json['translation'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      quality: json['quality'] as String? ?? '',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      directors: (json['directors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      ratingImdbValue: json['rating_imdb_value'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['rating_imdb_value']),
      ratingKinopoiskValue: json['rating_kinopoisk_value'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['rating_kinopoisk_value']),
      otherMovies: (json['other_movies'] as List<dynamic>?)
              ?.map((e) => OckgMovie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_OckgMovieToJson(_$_OckgMovie instance) =>
    <String, dynamic>{
      'movie_id': const IntConverter().toJson(instance.movieId),
      'name': instance.name,
      'international_name': instance.internationalName,
      'year': instance.year,
      'cover': instance.cover,
      'description': const HtmlRemoveConverter().toJson(instance.description),
      'translation': instance.translation,
      'quality': instance.quality,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'genres': instance.genres,
      'countries': instance.countries,
      'directors': instance.directors,
      'rating_imdb_value':
          const DoubleConverter().toJson(instance.ratingImdbValue),
      'rating_kinopoisk_value':
          const DoubleConverter().toJson(instance.ratingKinopoiskValue),
      'other_movies': instance.otherMovies,
    };
