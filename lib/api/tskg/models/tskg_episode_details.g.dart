// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_episode_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgEpisodeDetails _$TskgEpisodeDetailsFromJson(Map<String, dynamic> json) =>
    TskgEpisodeDetails(
      download: json['download'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      filename: json['filename'] as String? ?? '',
      fullname: json['fullname'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      link: json['link'] as String? ?? '',
      overlay: TskgEpisodeDetails.convertOverlayToJson(json['overlay']),
      name: json['name'] as String? ?? '',
      subtitles: json['subtitles'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      video: TskgEpisodeVideo.fromJson(json['video'] as Map<String, dynamic>),
      voice: json['voice'],
    );

Map<String, dynamic> _$TskgEpisodeDetailsToJson(TskgEpisodeDetails instance) =>
    <String, dynamic>{
      'download': instance.download,
      'duration': instance.duration,
      'filename': instance.filename,
      'fullname': instance.fullname,
      'id': instance.id,
      'link': instance.link,
      'overlay': instance.overlay,
      'name': instance.name,
      'subtitles': instance.subtitles,
      'title': instance.title,
      'video': instance.video,
      'voice': instance.voice,
    };

TskgEpisodeOverlay _$TskgEpisodeOverlayFromJson(Map<String, dynamic> json) =>
    TskgEpisodeOverlay(
      json['id'] as int,
      json['img'] as String,
      json['link'] as String,
    );

Map<String, dynamic> _$TskgEpisodeOverlayToJson(TskgEpisodeOverlay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'link': instance.link,
    };

TskgEpisodeVideo _$TskgEpisodeVideoFromJson(Map<String, dynamic> json) =>
    TskgEpisodeVideo(
      json['HD'] as bool,
      TskgEpisodeVideoFiles.fromJson(json['files'] as Map<String, dynamic>),
      json['mimetype'] as String,
      json['videotype'] as String,
    );

Map<String, dynamic> _$TskgEpisodeVideoToJson(TskgEpisodeVideo instance) =>
    <String, dynamic>{
      'HD': instance.hd,
      'files': instance.files,
      'mimetype': instance.mimetype,
      'videotype': instance.videotype,
    };

TskgEpisodeVideoFiles _$TskgEpisodeVideoFilesFromJson(
        Map<String, dynamic> json) =>
    TskgEpisodeVideoFiles(
      TskgEpisodeVideoFile.fromJson(json['HD'] as Map<String, dynamic>),
      TskgEpisodeVideoFile.fromJson(json['SD'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TskgEpisodeVideoFilesToJson(
        TskgEpisodeVideoFiles instance) =>
    <String, dynamic>{
      'HD': instance.hd,
      'SD': instance.sd,
    };

TskgEpisodeVideoFile _$TskgEpisodeVideoFileFromJson(
        Map<String, dynamic> json) =>
    TskgEpisodeVideoFile(
      json['id'] as int? ?? 0,
      json['server'] as String? ?? '',
      json['url'] as String? ?? '',
    );

Map<String, dynamic> _$TskgEpisodeVideoFileToJson(
        TskgEpisodeVideoFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'server': instance.server,
      'url': instance.url,
    };
