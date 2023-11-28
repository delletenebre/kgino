// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgItem _$TskgItemFromJson(Map<String, dynamic> json) => TskgItem(
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
      onlineService:
          $enumDecodeNullable(_$OnlineServiceEnumMap, json['online_service']) ??
              OnlineService.tskg,
      type: $enumDecodeNullable(_$MediaItemTypeEnumMap, json['type']) ??
          MediaItemType.show,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      subtitles: json['subtitles'] as bool? ?? false,
      voice: json['voice'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voice'] as Map<String, dynamic>),
      quality: json['quality'] as String? ?? '',
    );

Map<String, dynamic> _$TskgItemToJson(TskgItem instance) => <String, dynamic>{
      'online_service': _$OnlineServiceEnumMap[instance.onlineService]!,
      'type': _$MediaItemTypeEnumMap[instance.type]!,
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
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
      'date': instance.date?.toIso8601String(),
      'badges': instance.badges,
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
