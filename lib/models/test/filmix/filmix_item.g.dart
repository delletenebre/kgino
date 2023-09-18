// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmixItem _$FilmixItemFromJson(Map<String, dynamic> json) => FilmixItem(
      id: json['id'] == null
          ? ''
          : const StringConverter().fromJson(json['id']),
      title: json['title'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      poster: json['poster'] as String? ?? '',
      year: json['year'] == null
          ? ''
          : const StringConverter().fromJson(json['year']),
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      voiceActing: json['voice_acting'] as String? ?? '',
      voiceActings: (json['voice_actings'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      subtitlesEnabled: json['subtitles_enabled'] as bool? ?? false,
      bookmarked: json['bookmarked'] == null
          ? null
          : DateTime.parse(json['bookmarked'] as String),
      imdbRating: json['imdb_rating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['imdb_rating']),
      kinopoiskRating: json['kinopoisk_rating'] == null
          ? 0.0
          : const DoubleConverter().fromJson(json['kinopoisk_rating']),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shortStory: json['short_story'] == null
          ? ''
          : const HtmlRemoveConverter().fromJson(json['short_story'] as String),
      playerLinks: json['player_links'] == null
          ? const FlmxPlayerLinks()
          : FlmxPlayerLinks.fromJson(
              json['player_links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilmixItemToJson(FilmixItem instance) =>
    <String, dynamic>{
      'id': const StringConverter().toJson(instance.id),
      'title': instance.title,
      'original_title': instance.originalTitle,
      'poster': instance.poster,
      'year': const StringConverter().toJson(instance.year),
      'countries': instance.countries,
      'voice_acting': instance.voiceActing,
      'voice_actings': instance.voiceActings,
      'subtitles_enabled': instance.subtitlesEnabled,
      'bookmarked': instance.bookmarked?.toIso8601String(),
      'imdb_rating': const DoubleConverter().toJson(instance.imdbRating),
      'kinopoisk_rating':
          const DoubleConverter().toJson(instance.kinopoiskRating),
      'categories': instance.categories,
      'short_story': const HtmlRemoveConverter().toJson(instance.shortStory),
      'player_links': instance.playerLinks,
    };
