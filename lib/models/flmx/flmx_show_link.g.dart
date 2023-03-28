// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flmx_show_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FlmxShowLink _$$_FlmxShowLinkFromJson(Map<String, dynamic> json) =>
    _$_FlmxShowLink(
      link: json['link'] as String? ?? '',
      qualities: (json['qualities'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_FlmxShowLinkToJson(_$_FlmxShowLink instance) =>
    <String, dynamic>{
      'link': instance.link,
      'qualities': instance.qualities,
    };
