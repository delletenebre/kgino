// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TskgEpisode _$$_TskgEpisodeFromJson(Map<String, dynamic> json) =>
    _$_TskgEpisode(
      id: json['id'] as int? ?? 0,
      showId: json['showId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      duration: json['duration'] == null
          ? Duration.zero
          : Duration(microseconds: json['duration'] as int),
    );

Map<String, dynamic> _$$_TskgEpisodeToJson(_$_TskgEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'showId': instance.showId,
      'title': instance.title,
      'description': instance.description,
      'quality': instance.quality,
      'duration': instance.duration.inMicroseconds,
    };
