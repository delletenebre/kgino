// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezka_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezkaItem _$RezkaItemFromJson(Map<String, dynamic> json) => RezkaItem(
      id: const StringConverter().fromJson(json['id']),
      title: json['title'] as String,
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      year: json['year'] == null
          ? ''
          : const StringConverter().fromJson(json['year']),
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      imdbRating: json['imdb_rating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdb_rating']),
      kinopoiskRating: json['kinopoisk_rating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kinopoisk_rating']),
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => MediaItemSeason.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      voices: (json['voices'] as List<dynamic>?)
              ?.map((e) => VoiceActing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      poster: json['poster'] as String? ?? '',
      onlineService:
          $enumDecodeNullable(_$OnlineServiceEnumMap, json['online_service']) ??
              OnlineService.tskg,
      type: $enumDecodeNullable(_$MediaItemTypeEnumMap, json['type']) ??
          MediaItemType.show,
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      subtitles: json['subtitles'] as bool? ?? false,
      voice: json['voice'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voice'] as Map<String, dynamic>),
      quality: json['quality'] as String? ?? '720p',
    );

Map<String, dynamic> _$RezkaItemToJson(RezkaItem instance) => <String, dynamic>{
      'online_service': _$OnlineServiceEnumMap[instance.onlineService]!,
      'type': _$MediaItemTypeEnumMap[instance.type]!,
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster': instance.poster,
      'year': const StringConverter().toJson(instance.year),
      'genres': instance.genres,
      'countries': instance.countries,
      'voices': instance.voices.map((e) => e.toJson()).toList(),
      'imdb_rating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoisk_rating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'bookmarked': instance.bookmarked?.toIso8601String(),
      'subtitles': instance.subtitles,
      'voice': instance.voice.toJson(),
      'quality': instance.quality,
    };

const _$OnlineServiceEnumMap = {
  OnlineService.none: 'none',
  OnlineService.filmix: 'filmix',
  OnlineService.tskg: 'tskg',
};

const _$MediaItemTypeEnumMap = {
  MediaItemType.unknown: 'unknown',
  MediaItemType.show: 'show',
  MediaItemType.movie: 'movie',
  MediaItemType.folder: 'folder',
};
