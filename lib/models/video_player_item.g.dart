// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_player_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoPlayerItem _$$_VideoPlayerItemFromJson(Map<String, dynamic> json) =>
    _$_VideoPlayerItem(
      videoUrl: json['videoUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      startTime: json['startTime'] as int? ?? 0,
    );

Map<String, dynamic> _$$_VideoPlayerItemToJson(_$_VideoPlayerItem instance) =>
    <String, dynamic>{
      'videoUrl': instance.videoUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'startTime': instance.startTime,
    };
