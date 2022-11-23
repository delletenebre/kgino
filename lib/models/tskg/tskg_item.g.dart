// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TskgItem _$$_TskgItemFromJson(Map<String, dynamic> json) => _$_TskgItem(
      showId: json['showId'] as String,
      date: DateTime.parse(json['date'] as String),
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      genres: json['genres'] as String? ?? '',
      link: json['link'] as String? ?? '',
    );

Map<String, dynamic> _$$_TskgItemToJson(_$_TskgItem instance) =>
    <String, dynamic>{
      'showId': instance.showId,
      'date': instance.date.toIso8601String(),
      'badges': instance.badges,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'genres': instance.genres,
      'link': instance.link,
    };
