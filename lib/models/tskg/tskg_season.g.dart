// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TskgSeason _$$_TskgSeasonFromJson(Map<String, dynamic> json) =>
    _$_TskgSeason(
      title: json['title'] as String? ?? '',
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => TskgEpisode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TskgSeasonToJson(_$_TskgSeason instance) =>
    <String, dynamic>{
      'title': instance.title,
      'episodes': instance.episodes,
    };
