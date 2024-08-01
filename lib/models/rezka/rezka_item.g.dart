// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezka_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezkaItem _$RezkaItemFromJson(Map<String, dynamic> json) => RezkaItem(
      onlineService:
          $enumDecodeNullable(_$OnlineServiceEnumMap, json['onlineService']) ??
              OnlineService.rezka,
      id: const StringConverter().fromJson(json['id']),
      title: json['title'] as String,
      originalTitle: json['originalTitle'] as String? ?? '',
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
      imdbRating: json['imdbRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdbRating']),
      kinopoiskRating: json['kinopoiskRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kinopoiskRating']),
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => MediaItemSeason.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      voices: (json['voices'] as List<dynamic>?)
              ?.map((e) => VoiceActing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      poster: json['poster'] as String? ?? '',
      type: $enumDecodeNullable(_$MediaItemTypeEnumMap, json['type']) ??
          MediaItemType.show,
      seasonCount: (json['seasonCount'] as num?)?.toInt() ?? 0,
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      subtitlesEnabled: json['subtitlesEnabled'] as bool? ?? true,
      voiceActing: json['voiceActing'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voiceActing'] as Map<String, dynamic>),
      quality: json['quality'] as String? ?? '720p',
      blockedStatus: json['blockedStatus'] as String?,
    )..historied = json['historied'] == null
        ? null
        : DateTime.parse(json['historied'] as String);

Map<String, dynamic> _$RezkaItemToJson(RezkaItem instance) => <String, dynamic>{
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
      'overview': instance.overview,
      'year': const StringConverter().toJson(instance.year),
      'genres': instance.genres,
      'countries': instance.countries,
      'seasonCount': instance.seasonCount,
      'imdbRating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoiskRating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'voices': instance.voices.map((e) => e.toJson()).toList(),
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
