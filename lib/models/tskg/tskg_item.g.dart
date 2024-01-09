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
    )
      ..voiceActing =
          VoiceActing.fromJson(json['voiceActing'] as Map<String, dynamic>)
      ..subtitlesEnabled = json['subtitlesEnabled'] as bool
      ..bookmarked = json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String)
      ..seasons = (json['seasons'] as List<dynamic>)
          .map((e) => MediaItemSeason.fromJson(e as Map<String, dynamic>))
          .toList()
      ..voices = (json['voices'] as List<dynamic>)
          .map((e) => VoiceActing.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TskgItemToJson(TskgItem instance) => <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'type': _$MediaItemTypeEnumMap[instance.type]!,
      'voiceActing': instance.voiceActing.toJson(),
      'subtitlesEnabled': instance.subtitlesEnabled,
      'bookmarked': instance.bookmarked?.toIso8601String(),
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
    };

const _$MediaItemTypeEnumMap = {
  MediaItemType.show: 'show',
  MediaItemType.movie: 'movie',
  MediaItemType.folder: 'folder',
};
