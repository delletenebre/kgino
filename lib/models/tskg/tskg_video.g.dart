// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TskgVideo _$$_TskgVideoFromJson(Map<String, dynamic> json) => _$_TskgVideo(
      mimetype: json['mimetype'] as String? ?? '',
      videotype: json['videotype'] as String? ?? '',
      subtitles: json['subtitles'] as String? ?? '',
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_TskgVideoToJson(_$_TskgVideo instance) =>
    <String, dynamic>{
      'mimetype': instance.mimetype,
      'videotype': instance.videotype,
      'subtitles': instance.subtitles,
      'url': instance.url,
    };
