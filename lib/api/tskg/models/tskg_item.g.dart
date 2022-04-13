// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgItem _$TskgItemFromJson(Map<String, dynamic> json) => TskgItem(
      date: DateTime.parse(json['date'] as String),
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      genres: json['genres'] as String? ?? '',
      link: json['link'] as String? ?? '',
      showId: json['showId'] as String? ?? '',
    );

Map<String, dynamic> _$TskgItemToJson(TskgItem instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'badges': instance.badges,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'genres': instance.genres,
      'link': instance.link,
      'showId': instance.showId,
    };
