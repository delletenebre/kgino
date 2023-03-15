// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flmx_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FlmxItem _$$_FlmxItemFromJson(Map<String, dynamic> json) => _$_FlmxItem(
      id: json['id'] == null ? 0 : const IntConverter().fromJson(json['id']),
      section: json['section'] == null
          ? 0
          : const IntConverter().fromJson(json['section']),
      year: json['year'] == null
          ? 0
          : const IntConverter().fromJson(json['year']),
      yearEnd: json['year_end'] == null
          ? 0
          : const IntConverter().fromJson(json['year_end']),
      duration: json['duration'] == null
          ? 0
          : const IntConverter().fromJson(json['duration']),
      poster: json['poster'] as String? ?? '',
      title: json['title'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      dateAtom: json['date_atom'] == null
          ? null
          : DateTime.parse(json['date_atom'] as String),
      favorited: json['favorited'] as bool? ?? false,
      watchLater: json['watch_later'] as bool? ?? false,
      shortStory: json['short_story'] as String? ?? '',
      rip: json['rip'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      actors: (json['actors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      directors: (json['directors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      kpRating: json['kp_rating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kp_rating']),
      imdbRating: json['imdb_rating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdb_rating']),
    );

Map<String, dynamic> _$$_FlmxItemToJson(_$_FlmxItem instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'section': const IntConverter().toJson(instance.section),
      'year': const IntConverter().toJson(instance.year),
      'year_end': const IntConverter().toJson(instance.yearEnd),
      'duration': const IntConverter().toJson(instance.duration),
      'poster': instance.poster,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'date_atom': instance.dateAtom?.toIso8601String(),
      'favorited': instance.favorited,
      'watch_later': instance.watchLater,
      'short_story': instance.shortStory,
      'rip': instance.rip,
      'quality': instance.quality,
      'categories': instance.categories,
      'actors': instance.actors,
      'directors': instance.directors,
      'countries': instance.countries,
      'kp_rating': const DoubleConverter().toJson(instance.kpRating),
      'imdb_rating': const DoubleConverter().toJson(instance.imdbRating),
    };
