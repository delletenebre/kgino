// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmixItem _$FilmixItemFromJson(Map<String, dynamic> json) => FilmixItem(
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      title: json['title'] as String? ?? '',
      poster: json['poster'] as String? ?? '',
      type: $enumDecodeNullable(_$MediaItemTypeEnumMap, json['type']) ??
          MediaItemType.movie,
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
      seasonCount: json['season_count'] as int? ?? 0,
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      subtitlesEnabled: json['subtitles_enabled'] as bool? ?? true,
      voiceActing: json['voice_acting'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voice_acting'] as Map<String, dynamic>),
      quality: json['quality'] as String? ?? '720',
      duration: json['duration'] as int? ?? 0,
    );

Map<String, dynamic> _$FilmixItemToJson(FilmixItem instance) =>
    <String, dynamic>{
      'online_service': _$OnlineServiceEnumMap[instance.onlineService]!,
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'poster': instance.poster,
      'type': _$MediaItemTypeEnumMap[instance.type]!,
      'quality': instance.quality,
      'voice_acting': instance.voiceActing.toJson(),
      'subtitles_enabled': instance.subtitlesEnabled,
      'bookmarked': instance.bookmarked?.toIso8601String(),
      'original_title': instance.originalTitle,
      'year': const StringConverter().toJson(instance.year),
      'countries': instance.countries,
      'season_count': instance.seasonCount,
      'imdb_rating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoisk_rating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'voices': instance.voices.map((e) => e.toJson()).toList(),
      'categories': instance.categories,
      'short_story': const HtmlRemoveConverter().toJson(instance.shortStory),
      'player_links': instance.playerLinks?.toJson(),
      'duration': instance.duration,
    };

const _$MediaItemTypeEnumMap = {
  MediaItemType.show: 'show',
  MediaItemType.movie: 'movie',
  MediaItemType.folder: 'folder',
};

const _$OnlineServiceEnumMap = {
  OnlineService.none: 'none',
  OnlineService.filmix: 'filmix',
  OnlineService.tskg: 'tskg',
};
