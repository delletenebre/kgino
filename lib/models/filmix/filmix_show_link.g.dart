// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_show_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilmixShowLinkImpl _$$FilmixShowLinkImplFromJson(Map<String, dynamic> json) =>
    _$FilmixShowLinkImpl(
      link: json['link'] as String? ?? '',
      qualities: (json['qualities'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FilmixShowLinkImplToJson(
        _$FilmixShowLinkImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'qualities': instance.qualities,
    };
