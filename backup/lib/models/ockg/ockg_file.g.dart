// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgFile _$$_OckgFileFromJson(Map<String, dynamic> json) => _$_OckgFile(
      fileId: json['file_id'] == null
          ? 0
          : const IntConverter().fromJson(json['file_id']),
      name: json['name'] as String? ?? '',
      size: json['size'] == null
          ? 0
          : const IntConverter().fromJson(json['size']),
      isDir: json['is_dir'] as bool? ?? false,
      metainfo: OckgFileMeta.fromJson(json['metainfo'] as Map<String, dynamic>),
      frames: (json['frames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      quality: json['quality'] as String? ?? '',
      translation: (json['translation'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      path: json['path'] as String? ?? '',
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$$_OckgFileToJson(_$_OckgFile instance) =>
    <String, dynamic>{
      'file_id': const IntConverter().toJson(instance.fileId),
      'name': instance.name,
      'size': const IntConverter().toJson(instance.size),
      'is_dir': instance.isDir,
      'metainfo': instance.metainfo,
      'frames': instance.frames,
      'quality': instance.quality,
      'translation': instance.translation,
      'path': instance.path,
      'active': instance.active,
    };
