// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      originalTitle: json['originalTitle'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterImage: json['posterImage'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      year: json['year'] as String? ?? '',
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tmdb: json['tmdb'] == null
          ? null
          : TmdbItem.fromJson(json['tmdb'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'posterImage': instance.posterImage,
      'genres': instance.genres,
      'year': instance.year,
      'countries': instance.countries,
      'tmdb': instance.tmdb,
    };

_$_FilmixItem _$$_FilmixItemFromJson(Map<String, dynamic> json) =>
    _$_FilmixItem();

Map<String, dynamic> _$$_FilmixItemToJson(_$_FilmixItem instance) =>
    <String, dynamic>{};
