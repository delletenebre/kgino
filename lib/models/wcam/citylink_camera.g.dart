// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citylink_camera.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CitylinkCamera _$$_CitylinkCameraFromJson(Map<String, dynamic> json) =>
    _$_CitylinkCamera(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      img: json['img'] as String? ?? '',
      src: json['src'] as String? ?? '',
      download: json['download'] as String? ?? '',
      cityName: json['cityName'] as String? ?? '',
      audio: json['audio'] as int? ?? 0,
    );

Map<String, dynamic> _$$_CitylinkCameraToJson(_$_CitylinkCamera instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
      'src': instance.src,
      'download': instance.download,
      'cityName': instance.cityName,
      'audio': instance.audio,
    };
