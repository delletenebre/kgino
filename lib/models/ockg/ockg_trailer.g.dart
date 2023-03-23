// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_trailer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgTrailer _$$_OckgTrailerFromJson(Map<String, dynamic> json) =>
    _$_OckgTrailer(
      width: json['width'] == null
          ? 0
          : const IntConverter().fromJson(json['width']),
      height: json['height'] == null
          ? 0
          : const IntConverter().fromJson(json['height']),
      name: json['name'] as String? ?? '',
      preview: json['preview'] as String? ?? '',
      video: json['video'] as String? ?? '',
    );

Map<String, dynamic> _$$_OckgTrailerToJson(_$_OckgTrailer instance) =>
    <String, dynamic>{
      'width': const IntConverter().toJson(instance.width),
      'height': const IntConverter().toJson(instance.height),
      'name': instance.name,
      'preview': instance.preview,
      'video': instance.video,
    };
