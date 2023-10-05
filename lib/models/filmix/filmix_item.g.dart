// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmixItem _$FilmixItemFromJson(Map<String, dynamic> json) => FilmixItem(
      id: const StringConverter().fromJson(json['id']),
      title: json['title'] as String,
      poster: json['poster'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
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
              OnlineService.filmix,
      type: $enumDecodeNullable(_$MediaItemTypeEnumMap, json['type']) ??
          MediaItemType.unknown,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shortStory: json['short_story'] == null
          ? ''
          : const HtmlRemoveConverter().fromJson(json['short_story'] as String),
      playerLinks: json['player_links'] == null
          ? const FilmixPlayerLinks()
          : FilmixPlayerLinks.fromJson(
              json['player_links'] as Map<String, dynamic>),
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      subtitles: json['subtitles'] as bool? ?? false,
      voice: json['voice'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voice'] as Map<String, dynamic>),
      quality: json['quality'] == null
          ? 480
          : const IntConverter().fromJson(json['quality']),
    );

Map<String, dynamic> _$FilmixItemToJson(FilmixItem instance) =>
    <String, dynamic>{
      'online_service': _$OnlineServiceEnumMap[instance.onlineService]!,
      'type': _$MediaItemTypeEnumMap[instance.type]!,
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'original_title': instance.originalTitle,
      'poster': instance.poster,
      'year': const StringConverter().toJson(instance.year),
      'countries': instance.countries,
      'voices': instance.voices.map((e) => e.toJson()).toList(),
      'imdb_rating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoisk_rating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'bookmarked': instance.bookmarked?.toIso8601String(),
      'subtitles': instance.subtitles,
      'voice': instance.voice.toJson(),
      'quality': const IntConverter().toJson(instance.quality),
      'categories': instance.categories,
      'short_story': const HtmlRemoveConverter().toJson(instance.shortStory),
      'player_links': instance.playerLinks?.toJson(),
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
