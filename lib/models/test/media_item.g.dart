// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) => MediaItem(
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      title: json['title'] as String? ?? '',
      originalTitle: json['originalTitle'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      poster: json['poster'] as String? ?? '',
      year: json['year'] == null
          ? ''
          : const StringConverter().fromJson(json['year']),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      voiceActing: json['voiceActing'] as String? ?? '',
      voiceActings: (json['voiceActings'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      subtitlesEnabled: json['subtitlesEnabled'] as bool? ?? false,
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      imdbRating: json['imdbRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdbRating']),
      kinopoiskRating: json['kinopoiskRating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kinopoiskRating']),
    );

Map<String, dynamic> _$MediaItemToJson(MediaItem instance) => <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'poster': instance.poster,
      'year': const StringConverter().toJson(instance.year),
      'genres': instance.genres,
      'countries': instance.countries,
      'voiceActing': instance.voiceActing,
      'voiceActings': instance.voiceActings,
      'subtitlesEnabled': instance.subtitlesEnabled,
      'bookmarked': instance.bookmarked?.toIso8601String(),
      'imdbRating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoiskRating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
    };
