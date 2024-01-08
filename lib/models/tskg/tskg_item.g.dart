// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgItem _$TskgItemFromJson(Map<String, dynamic> json) => TskgItem(
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      title: json['title'] as String? ?? '',
      type: $enumDecodeNullable(_$MediaItemTypeEnumMap, json['type']) ??
          MediaItemType.show,
      overview: json['overview'] as String? ?? '',
      year: json['year'] == null
          ? ''
          : const StringConverter().fromJson(json['year']),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      seasonCount: json['seasonCount'] as int? ?? 0,
      imdbRating: json['imdbRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdbRating']),
      kinopoiskRating: json['kinopoiskRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kinopoiskRating']),
    );

Map<String, dynamic> _$TskgItemToJson(TskgItem instance) => <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'type': _$MediaItemTypeEnumMap[instance.type]!,
      'overview': instance.overview,
      'year': const StringConverter().toJson(instance.year),
      'genres': instance.genres,
      'countries': instance.countries,
      'seasonCount': instance.seasonCount,
      'imdbRating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoiskRating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
    };

const _$MediaItemTypeEnumMap = {
  MediaItemType.show: 'show',
  MediaItemType.movie: 'movie',
  MediaItemType.folder: 'folder',
};
