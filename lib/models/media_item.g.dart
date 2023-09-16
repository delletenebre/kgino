// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MediaItem _$$_MediaItemFromJson(Map<String, dynamic> json) => _$_MediaItem(
      onlineService: $enumDecode(_$OnlineServiceEnumMap, json['onlineService']),
      mediaItemType: $enumDecode(_$MediaItemTypeEnumMap, json['mediaItemType']),
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

Map<String, dynamic> _$$_MediaItemToJson(_$_MediaItem instance) =>
    <String, dynamic>{
      'onlineService': _$OnlineServiceEnumMap[instance.onlineService]!,
      'mediaItemType': _$MediaItemTypeEnumMap[instance.mediaItemType]!,
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

const _$OnlineServiceEnumMap = {
  OnlineService.filmix: 'filmix',
  OnlineService.tskg: 'tskg',
  OnlineService.tmdb: 'tmdb',
};

const _$MediaItemTypeEnumMap = {
  MediaItemType.movie: 'movie',
  MediaItemType.show: 'show',
};
