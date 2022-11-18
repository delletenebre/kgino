// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_file_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgFileMeta _$$_OckgFileMetaFromJson(Map<String, dynamic> json) =>
    _$_OckgFileMeta(
      playtimeSeconds: json['playtime_seconds'] == null
          ? 0
          : const IntConverter().fromJson(json['playtime_seconds']),
      format: json['format'] as String? ?? '',
      video: OckgFileMetaMedia.fromJson(json['video'] as Map<String, dynamic>),
      audio: OckgFileMetaMedia.fromJson(json['audio'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_OckgFileMetaToJson(_$_OckgFileMeta instance) =>
    <String, dynamic>{
      'playtime_seconds': const IntConverter().toJson(instance.playtimeSeconds),
      'format': instance.format,
      'video': instance.video,
      'audio': instance.audio,
    };
