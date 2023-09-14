// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MediaItem _$$_MediaItemFromJson(Map<String, dynamic> json) => _$_MediaItem(
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterUrl: json['posterUrl'] as String? ?? '',
      backdropUrl: json['backdropUrl'] as String? ?? '',
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_MediaItemToJson(_$_MediaItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'overview': instance.overview,
      'posterUrl': instance.posterUrl,
      'backdropUrl': instance.backdropUrl,
      'genres': instance.genres,
    };
