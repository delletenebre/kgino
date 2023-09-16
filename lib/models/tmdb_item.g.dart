// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TmdbItem _$$_TmdbItemFromJson(Map<String, dynamic> json) => _$_TmdbItem(
      title: json['title'] as String?,
      name: json['name'] as String?,
      overview: json['overview'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      firstAirDate: json['first_air_date'] as String?,
    );

Map<String, dynamic> _$$_TmdbItemToJson(_$_TmdbItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'name': instance.name,
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate,
    };
