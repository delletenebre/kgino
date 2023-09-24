// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_show_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FilmixShowLink _$$_FilmixShowLinkFromJson(Map<String, dynamic> json) =>
    _$_FilmixShowLink(
      link: json['link'] as String? ?? '',
      qualities: (json['qualities'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_FilmixShowLinkToJson(_$_FilmixShowLink instance) =>
    <String, dynamic>{
      'link': instance.link,
      'qualities': instance.qualities,
    };
