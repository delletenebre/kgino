// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmixItem _$FilmixItemFromJson(Map<String, dynamic> json) => FilmixItem(
      onlineService:
          $enumDecodeNullable(_$OnlineServiceEnumMap, json['onlineService']) ??
              OnlineService.filmix,
      id: const StringConverter().fromJson(json['id']),
      title: json['title'] as String,
      poster: json['poster'] as String,
      type: $enumDecodeNullable(_$MediaItemTypeEnumMap, json['type']) ??
          MediaItemType.movie,
      quality: json['quality'] as String? ?? '720',
      originalTitle: json['originalTitle'] as String? ?? '',
      year: json['year'] == null
          ? ''
          : const StringConverter().fromJson(json['year']),
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => MediaItemSeason.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      voices: (json['voices'] as List<dynamic>?)
              ?.map((e) => VoiceActing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      blockedStatus: json['blockedStatus'] as String?,
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
      subtitlesEnabled: json['subtitlesEnabled'] as bool? ?? true,
      voiceActing: json['voiceActing'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voiceActing'] as Map<String, dynamic>),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
    )
      ..historied = json['historied'] == null
          ? null
          : DateTime.parse(json['historied'] as String)
      ..imdbRating = const DoubleConverter().fromJson(json['imdbRating'])
      ..kinopoiskRating =
          const DoubleConverter().fromJson(json['kinopoiskRating']);

Map<String, dynamic> _$FilmixItemToJson(FilmixItem instance) =>
    <String, dynamic>{
      'onlineService': _$OnlineServiceEnumMap[instance.onlineService]!,
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'poster': instance.poster,
      'type': _$MediaItemTypeEnumMap[instance.type]!,
      'quality': instance.quality,
      'voiceActing': instance.voiceActing.toJson(),
      'subtitlesEnabled': instance.subtitlesEnabled,
      'bookmarked': instance.bookmarked?.toIso8601String(),
      'historied': instance.historied?.toIso8601String(),
      'originalTitle': instance.originalTitle,
      'year': const StringConverter().toJson(instance.year),
      'countries': instance.countries,
      'imdbRating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoiskRating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'voices': instance.voices.map((e) => e.toJson()).toList(),
      'categories': instance.categories,
      'short_story': const HtmlRemoveConverter().toJson(instance.shortStory),
      'player_links': instance.playerLinks?.toJson(),
      'duration': instance.duration,
      'blockedStatus': instance.blockedStatus,
    };

const _$OnlineServiceEnumMap = {
  OnlineService.none: 'none',
  OnlineService.filmix: 'filmix',
  OnlineService.rezka: 'rezka',
  OnlineService.tskg: 'tskg',
};

const _$MediaItemTypeEnumMap = {
  MediaItemType.show: 'show',
  MediaItemType.movie: 'movie',
  MediaItemType.folder: 'folder',
  MediaItemType.error: 'error',
};
