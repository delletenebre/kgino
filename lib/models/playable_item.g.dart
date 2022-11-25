// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playable_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayableItem _$$_PlayableItemFromJson(Map<String, dynamic> json) =>
    _$_PlayableItem(
      videoUrl: json['videoUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      startTime: json['startTime'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PlayableItemToJson(_$_PlayableItem instance) =>
    <String, dynamic>{
      'videoUrl': instance.videoUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'startTime': instance.startTime,
    };
