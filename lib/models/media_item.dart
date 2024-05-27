import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../extensions/duration_extensions.dart';
import '../extensions/json_converters.dart';
import '../resources/kika_storage.dart';
import 'filmix/filmix_item.dart';
import 'media_item_episode.dart';
import 'media_item_season.dart';
import 'media_item_url.dart';
import 'rezka/rezka_item.dart';
import 'tskg/tskg_item.dart';
import 'voice_acting.dart';

export 'media_item_episode.dart';
export 'media_item_season.dart';
export 'voice_acting.dart';

part 'media_item.g.dart';

/// онлайн-сервисы
enum OnlineService {
  none,
  filmix,
  rezka,
  tskg;

  String get logo {
    switch (this) {
      case OnlineService.tskg:
        return 'assets/images/tskg.svg';
      case OnlineService.filmix:
        return 'assets/images/filmix.svg';
      case OnlineService.rezka:
        return 'assets/images/rezka.png';
      case OnlineService.none:
        return '';
    }
  }
}

/// тип медиа-контента
enum MediaItemType {
  show,
  movie,
  folder,
  error,
}

abstract interface class Playable {
  Future<MediaItem> loadDetails(Ref ref, CancelToken? cancelToken);
  Future<List<MediaItemSeason>> loadSeasons(Ref ref);
  Future<List<VoiceActing>> loadVoices(Ref ref);
  Future<MediaItemUrl> loadEpisodeUrl(WidgetRef ref, MediaItemEpisode episode);
}

@JsonSerializable(explicitToJson: true)
@collection
class MediaItem implements Playable {
  /// идентификатор в базе данных
  @Id()
  String get dbId => '${onlineService.name}|$id';

  /// онлайн-сервис
  @enumValue
  @JsonKey(name: 'onlineService')
  final OnlineService onlineService;

  /// идентификатор на сервисе
  @StringConverter()
  String id;

  /// название
  final String title;

  /// постер
  final String poster;

  /// изображение на фон
  @ignore
  String get backdrop => poster;

  /// тип контента
  MediaItemType type;

  /// выбранное качество видео
  String quality;

  /// выбранный вариант озвучки
  @JsonKey(name: 'voiceActing')
  VoiceActing voiceActing;

  /// включены ли субтитры
  @JsonKey(name: 'subtitlesEnabled')
  bool subtitlesEnabled;

  /// дата добавления в избранное
  DateTime? bookmarked;

  /// оригинальное название
  @ignore
  @JsonKey(name: 'originalTitle')
  final String originalTitle;

  /// описание
  @ignore
  final String overview;

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

  /// количество сезонов
  @ignore
  @JsonKey(name: 'seasonCount')
  final int seasonCount;

  /// рейтинг IMDb
  @DoubleConverter()
  @JsonKey(name: 'imdbRating')
  @ignore
  double imdbRating;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @ignore
  bool get hasImdbRating => imdbRating > 0.0;

  /// рейтинг КиноПоиск
  @DoubleConverter()
  @JsonKey(name: 'kinopoiskRating')
  @ignore
  double kinopoiskRating;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @ignore
  bool get hasKinopoiskRating => kinopoiskRating > 0.0;

  /// сезоны
  @ignore
  List<MediaItemSeason> seasons;

  /// варианты озвучки
  @ignore
  List<VoiceActing> voices;

  MediaItem({
    this.onlineService = OnlineService.none,
    this.id = '',
    this.title = '',
    this.poster = '',
    this.quality = '',
    this.voiceActing = const VoiceActing(),
    this.subtitlesEnabled = true,
    this.bookmarked,

    /// не в базе данных
    this.type = MediaItemType.folder,
    this.originalTitle = '',
    this.overview = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
    this.seasonCount = 0,
    this.imdbRating = 0.0,
    this.kinopoiskRating = 0.0,
    this.seasons = const [],
    this.voices = const [],
    this.blockedStatus,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  /// является ли текущий элемент "директорией"
  @ignore
  bool get isFolder => (type == MediaItemType.folder);

  /// является ли текущий элемент "НЕ директорией"
  @ignore
  bool get isNotFolder => (type != MediaItemType.folder);

  /// является ли текущий элемент "кнопкой ошибки"
  @ignore
  bool get isError => (type == MediaItemType.error);

  /// является ли текущий элемент "сериалом"
  @ignore
  bool get isShow => (type == MediaItemType.show);

  /// заблокирован ли контент правообладателем
  @ignore
  bool get blocked => blockedStatus?.isNotEmpty == true;

  @ignore
  @JsonKey(name: 'blockedStatus')
  final String? blockedStatus;

  /// продолжительность для информации
  String overviewDuration(BuildContext context) {
    switch (type) {
      case MediaItemType.folder:
      case MediaItemType.error:
        return '';
      case MediaItemType.show:
        return localeSeasonsCount(seasonCount);
      case MediaItemType.movie:
        return Duration(
                seconds:
                    seasons.firstOrNull?.episodes.firstOrNull?.duration ?? 0)
            .formatted;
    }
  }

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
    } else if (averageRating < 5.0) {
      return '☆☆☆';
    } else if (averageRating < 6.0) {
      return '★☆☆';
    } else if (averageRating < 7.7) {
      return '★★☆';
    } else {
      return '★★★';
    }
  }

  /// общий список всех эпизодов
  @ignore
  List<MediaItemEpisode> get episodes =>
      seasons.expand((season) => season.episodes).toList();

  String localeSeasonsCount(int count) {
    return Intl.pluralLogic(
      count,
      locale: 'ru',
      other: '$count сезона',
      many: '$count сезонов',
      few: '$count сезона',
      one: '$count сезон',
      zero: '$count сезонов',
    );
  }

  /// загрузка подробных данных о сериале или фильме
  @override
  loadDetails(Ref ref, CancelToken? cancelToken) => throw UnimplementedError();

  /// получение списка сезонов
  @override
  loadSeasons(Ref ref) => throw UnimplementedError();

  /// получение списка вариантов озвучки
  @override
  loadVoices(Ref ref) => throw UnimplementedError();

  /// получение ссылки на эпизод
  @override
  loadEpisodeUrl(WidgetRef ref, MediaItemEpisode episode) async {
    if (episode.videoFileUrl.isNotEmpty) {
      return MediaItemUrl(video: episode.videoFileUrl);
    }

    throw UnimplementedError();
  }

  /// находим сохранённый в базе данных сериал или фильм
  MediaItem findSaved(KikaStorage storage) {
    final savedItem = storage.db.mediaItems.get(dbId);
    if (savedItem != null) {
      switch (savedItem.onlineService) {
        case OnlineService.none:
          return savedItem;
        case OnlineService.filmix:
          return FilmixItem.fromJson(savedItem.toJson());
        case OnlineService.tskg:
          return TskgItem.fromJson(savedItem.toJson());
        case OnlineService.rezka:
          return RezkaItem.fromJson(savedItem.toJson());
      }
    }

    return this;
  }

  /// сохранение в базу данных
  Future<void> save(KikaStorage storage) async => storage.db.writeAsync((isar) {
        isar.mediaItems.put(this);
      });

  MediaItem fromDatabase() {
    if (onlineService == OnlineService.filmix) {
      return FilmixItem.fromJson(toJson());
    }
    if (onlineService == OnlineService.tskg) {
      return TskgItem.fromJson(toJson());
    }
    if (onlineService == OnlineService.rezka) {
      return RezkaItem.fromJson(toJson());
    }

    throw Exception();
  }

  // int fastHash(String string) {
  //   var hash = 0xcbf29ce484222325;

  //   var i = 0;
  //   while (i < string.length) {
  //     final codeUnit = string.codeUnitAt(i++);
  //     hash ^= codeUnit >> 8;
  //     hash *= 0x100000001b3;
  //     hash ^= codeUnit & 0xFF;
  //     hash *= 0x100000001b3;
  //   }

  //   return hash;
  // }
}

// extension MediaItemExtensions on MediaItem {
//   MediaItem fromDatabase() {
//     if (onlineService == OnlineService.filmix) {
//       return FilmixItem.fromJson(toJson());
//     }
//     if (onlineService == OnlineService.tskg) {
//       return TskgItem.fromJson(toJson());
//     }
//     if (onlineService == OnlineService.rezka) {
//       return RezkaItem.fromJson(toJson());
//     }

//     return this;
//   }
// }
