// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TmdbItemImpl _$$TmdbItemImplFromJson(Map<String, dynamic> json) =>
    _$TmdbItemImpl(
      title: json['title'] as String?,
      name: json['name'] as String?,
      overview: json['overview'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      firstAirDate: json['first_air_date'] as String?,
    );

Map<String, dynamic> _$$TmdbItemImplToJson(_$TmdbItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'name': instance.name,
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate,
    };
