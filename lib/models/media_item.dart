import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';
import '../enums/online_service.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_storage.dart';
import 'filmix/filmix_item.dart';
import 'media_item_episode.dart';
import 'media_item_season.dart';
import 'tskg/tskg_item.dart';
import 'voice_acting.dart';

export 'media_item_season.dart';
export 'media_item_episode.dart';

part 'media_item.g.dart';

/// тип медиа-контента
enum MediaItemType {
  none,
  show,
  movie,
}

@JsonSerializable(explicitToJson: true)
@collection
class MediaItem {
  @Id()
  String get isarId => '${onlineService.name}|$id';

  /// название онлайн-сервиса
  final OnlineService onlineService;

  /// тип контента
  @JsonKey(includeFromJson: false)
  MediaItemType type;

  /// идентификатор на сервисе
  @StringConverter()
  final String id;

  /// название
  final String title;

  /// оригинальное название
  @ignore
  final String originalTitle;

  /// описание
  @ignore
  final String overview;

  /// постер
  final String poster;

  /// год
  @StringConverter()
  @ignore
  final String year;

  /// жанры
  @ignore
  final List<String> genres;

  /// страны
  @ignore
  final List<String> countries;

  /// варианты озвучки
  @ignore
  List<VoiceActing> voices;

  /// рейтинг IMDb
  @DoubleConverter()
  @ignore
  final double imdbRating;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @ignore
  bool get hasImdbRating => imdbRating > 0.0;

  /// рейтинг Кинопоиск
  @DoubleConverter()
  @ignore
  final double kinopoiskRating;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @ignore
  bool get hasKinopoiskRating => kinopoiskRating > 0.0;

  /// сезоны
  @ignore
  List<MediaItemSeason> seasons = [];

  /// дата добавления в закладки
  DateTime? bookmarked;

  /// включены или выключены субтитры
  bool subtitles;

  /// выбранная озвучка
  VoiceActing voice;

  /// выбранное качество видео
  @IntConverter()
  int quality;

  MediaItem({
    required this.id,
    required this.title,
    this.originalTitle = '',
    this.overview = '',
    this.poster = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
    this.voices = const [],
    this.imdbRating = 0.0,
    this.kinopoiskRating = 0.0,
    this.seasons = const [],
    this.type = MediaItemType.none,
    this.onlineService = OnlineService.none,

    ///
    this.bookmarked,
    this.subtitles = false,
    this.voice = const VoiceActing(),
    this.quality = 0,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  /// заблокирован ли контент правообладателем
  @ignore
  bool get blocked => throw UnimplementedError();

  /// изображение на фон
  String get backdrop => poster;

  /// усреднённый рейтинг
  @ignore
  double get averageRating {
    int ratingsCount = 0;
    if (hasImdbRating) {
      ratingsCount++;
    }

    if (hasKinopoiskRating) {
      ratingsCount++;
    }

    if (ratingsCount == 0) {
      return 0.0;
    }

    return (imdbRating + kinopoiskRating) / ratingsCount;
  }

  /// отображаемый рейтинг
  @ignore
  String get ratingStars {
    if (averageRating == 0.0) {
      return '';
    } else if (averageRating < 4.5) {
      return '☆☆☆';
    } else if (averageRating < 6.0) {
      return '★☆☆';
    } else if (averageRating < 7.7) {
      return '★★☆';
    } else {
      return '★★★';
    }
  }

  /// загрузка подробных данных о сериале или фильме
  Future<MediaItem> loadDetails(Ref ref) {
    throw UnimplementedError();
  }

  /// загрузка эпизода
  Future<String> loadEpisodeUrl({
    required WidgetRef ref,
    required int episodeIndex,
  }) {
    throw UnimplementedError();
  }

  /// общий список всех эпизодов
  List<MediaItemEpisode> episodes() {
    return seasons.expand((season) => season.episodes).toList();
  }

  /// сохранение в базу данных
  Future<void> save(KrsStorage storage) async {
    storage.db.writeAsync((isar) async {
      isar.mediaItems.put(this);
    });
  }

  MediaItem? findSaved(KrsStorage storage) {
    final savedItem = storage.db.mediaItems.get(isarId);
    if (savedItem != null) {
      switch (savedItem.onlineService) {
        case OnlineService.none:
          return savedItem;
        case OnlineService.filmix:
          return FilmixItem.fromJson(savedItem.toJson());
        case OnlineService.tskg:
          return TskgItem.fromJson(savedItem.toJson());
      }
    }

    return null;
  }

  /// продолжительность для информации
  String overviewDuration(BuildContext context) {
    final locale = KrsLocale.of(context);
    switch (type) {
      case MediaItemType.none:
        return '';
      case MediaItemType.show:
        return seasons.length > 1
            ? locale.seasonsCount(seasons.length)
            : locale.episodesCount(episodes().length);
      case MediaItemType.movie:
        return '';
    }
  }

  // Stream<MediaItem?> dbStream(KrsStorage storage) {
  //   return storage.db.mediaItems.watchObject(id);
  // }
}
