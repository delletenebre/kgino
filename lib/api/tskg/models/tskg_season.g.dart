// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgSeason _$TskgSeasonFromJson(Map<String, dynamic> json) => TskgSeason(
      title: json['title'] as String? ?? '',
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => TskgEpisode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TskgSeasonToJson(TskgSeason instance) =>
    <String, dynamic>{
      'title': instance.title,
      'episodes': instance.episodes,
    };
