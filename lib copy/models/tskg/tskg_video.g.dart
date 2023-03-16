// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TskgVideo _$$_TskgVideoFromJson(Map<String, dynamic> json) => _$_TskgVideo(
      hd: json['HD'] as bool? ?? false,
      files: TskgVideoFiles.fromJson(json['files'] as Map<String, dynamic>),
      mimetype: json['mimetype'] as String? ?? '',
      videotype: json['videotype'] as String? ?? '',
      subtitles: json['subtitles'] as String? ?? '',
    );

Map<String, dynamic> _$$_TskgVideoToJson(_$_TskgVideo instance) =>
    <String, dynamic>{
      'HD': instance.hd,
      'files': instance.files,
      'mimetype': instance.mimetype,
      'videotype': instance.videotype,
      'subtitles': instance.subtitles,
    };

_$_TskgVideoFiles _$$_TskgVideoFilesFromJson(Map<String, dynamic> json) =>
    _$_TskgVideoFiles(
      hd: TskgVideoFile.fromJson(json['HD'] as Map<String, dynamic>),
      sd: TskgVideoFile.fromJson(json['SD'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TskgVideoFilesToJson(_$_TskgVideoFiles instance) =>
    <String, dynamic>{
      'HD': instance.hd,
      'SD': instance.sd,
    };

_$_TskgVideoFile _$$_TskgVideoFileFromJson(Map<String, dynamic> json) =>
    _$_TskgVideoFile(
      id: json['id'] as int? ?? 0,
      server: json['server'] as String? ?? '',
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$_TskgVideoFileToJson(_$_TskgVideoFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'server': instance.server,
      'url': instance.url,
    };
