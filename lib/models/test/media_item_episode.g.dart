// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItemEpisode _$MediaItemEpisodeFromJson(Map<String, dynamic> json) =>
    MediaItemEpisode(
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      videoFileUrl: json['videoFileUrl'] as String? ?? '',
      qualities: (json['qualities'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MediaItemEpisodeToJson(MediaItemEpisode instance) =>
    <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'videoFileUrl': instance.videoFileUrl,
      'qualities': instance.qualities,
    };
