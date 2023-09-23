// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item_season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItemSeason _$MediaItemSeasonFromJson(Map<String, dynamic> json) =>
    MediaItemSeason(
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      name: json['name'] as String? ?? '',
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => MediaItemEpisode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MediaItemSeasonToJson(MediaItemSeason instance) =>
    <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'name': instance.name,
      'episodes': instance.episodes.map((e) => e.toJson()).toList(),
    };
