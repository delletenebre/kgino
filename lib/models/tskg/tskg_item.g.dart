// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgItem _$TskgItemFromJson(Map<String, dynamic> json) => TskgItem(
      onlineService:
          $enumDecodeNullable(_$OnlineServiceEnumMap, json['onlineService']) ??
              OnlineService.tskg,
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      title: json['title'] as String? ?? '',
      originalTitle: json['originalTitle'] as String? ?? '',
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
      seasonCount: (json['seasonCount'] as num?)?.toInt() ?? 0,
      imdbRating: json['imdbRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdbRating']),
      kinopoiskRating: json['kinopoiskRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kinopoiskRating']),
      voiceActing: json['voiceActing'] == null
          ? const VoiceActing()
          : VoiceActing.fromJson(json['voiceActing'] as Map<String, dynamic>),
      voices: (json['voices'] as List<dynamic>?)
              ?.map((e) => VoiceActing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      blockedStatus: json['blockedStatus'] as String?,
    )
      ..quality = json['quality'] as String
      ..subtitlesEnabled = json['subtitlesEnabled'] as bool
      ..bookmarked = json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String)
      ..historied = json['historied'] == null
          ? null
          : DateTime.parse(json['historied'] as String)
      ..seasons = (json['seasons'] as List<dynamic>)
          .map((e) => MediaItemSeason.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TskgItemToJson(TskgItem instance) => <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
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
      'onlineService': _$OnlineServiceEnumMap[instance.onlineService]!,
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
