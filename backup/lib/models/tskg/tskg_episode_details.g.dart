// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_episode_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TskgEpisodeDetails _$$_TskgEpisodeDetailsFromJson(
        Map<String, dynamic> json) =>
    _$_TskgEpisodeDetails(
      id: json['id'] as int? ?? 0,
      download: json['download'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      filename: json['filename'] as String? ?? '',
      fullname: json['fullname'] as String? ?? '',
      link: json['link'] as String? ?? '',
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      video: TskgVideo.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TskgEpisodeDetailsToJson(
        _$_TskgEpisodeDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'download': instance.download,
      'duration': instance.duration,
      'filename': instance.filename,
      'fullname': instance.fullname,
      'link': instance.link,
      'name': instance.name,
      'title': instance.title,
      'video': instance.video,
    };
