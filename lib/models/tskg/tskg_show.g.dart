// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TskgShow _$$_TskgShowFromJson(Map<String, dynamic> json) => _$_TskgShow(
      showId: json['showId'] as String? ?? '',
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      link: json['link'] as String? ?? '',
      originalTitle: json['originalTitle'] as String? ?? '',
      years: json['years'] as String? ?? '',
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      description: json['description'] as String? ?? '',
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => TskgSeason.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TskgShowToJson(_$_TskgShow instance) =>
    <String, dynamic>{
      'showId': instance.showId,
      'date': instance.date?.toIso8601String(),
      'badges': instance.badges,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'genres': instance.genres,
      'link': instance.link,
      'originalTitle': instance.originalTitle,
      'years': instance.years,
      'countries': instance.countries,
      'description': instance.description,
      'seasons': instance.seasons,
    };
