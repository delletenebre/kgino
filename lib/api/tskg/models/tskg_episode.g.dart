// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgEpisode _$TskgEpisodeFromJson(Map<String, dynamic> json) => TskgEpisode(
      id: json['id'] as int? ?? 0,
      showId: json['showId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      duration: Duration(microseconds: json['duration'] as int),
    );

Map<String, dynamic> _$TskgEpisodeToJson(TskgEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'showId': instance.showId,
      'title': instance.title,
      'description': instance.description,
      'quality': instance.quality,
      'duration': instance.duration.inMicroseconds,
    };
