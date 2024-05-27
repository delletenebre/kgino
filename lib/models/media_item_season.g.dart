// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item_season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaItemSeasonImpl _$$MediaItemSeasonImplFromJson(
        Map<String, dynamic> json) =>
    _$MediaItemSeasonImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => MediaItemEpisode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MediaItemEpisode>[],
    );

Map<String, dynamic> _$$MediaItemSeasonImplToJson(
        _$MediaItemSeasonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'episodes': instance.episodes,
    };
