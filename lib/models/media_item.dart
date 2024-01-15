import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../extensions/duration_extensions.dart';
import '../extensions/json_converters.dart';
import '../resources/krs_storage.dart';
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
}

abstract interface class Playable {
  Future<MediaItem> loadDetails(Ref ref);
  Future<List<MediaItemSeason>> loadSeasons(Ref ref);
  Future<List<VoiceActing>> loadVoices(Ref ref);
  Future<MediaItemUrl> loadEpisodeUrl(WidgetRef ref, MediaItemEpisode episode);
}

@JsonSerializable(explicitToJson: true)
@collection
class MediaItem implements Playable {
  /// идентификатор в базе данных
  @Id()
  String get isarId => '${onlineService.name}|$id';

  /// онлайн-сервис
  @enumValue
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
  bool subtitlesEnabled;

  /// дата добавления в избранное
  DateTime? bookmarked;

  /// оригинальное название
  @ignore
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
  final int seasonCount;

  /// рейтинг IMDb
  @DoubleConverter()
  @ignore
  final double imdbRating;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @ignore
  bool get hasImdbRating => imdbRating > 0.0;

  /// рейтинг КиноПоиск
  @DoubleConverter()
  @ignore
  final double kinopoiskRating;
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
  });

  // MediaItem copyWith(
  //         {String? id,
  //         VoiceActing? voice,
  //         List<MediaItemSeason>? seasons,
  //         List<VoiceActing>? voices}) =>
  //     MediaItem(
  //       onlineService: onlineService,
  //       id: id ?? this.id,
  //       title: title,
  //       poster: poster,
  //       // originalTitle: originalTitle,
  //       overview: overview,
  //       year: year,
  //       genres: genres,
  //       countries: countries,
  //       // voices: voices,
  //       imdbRating: imdbRating,
  //       kinopoiskRating: kinopoiskRating,
  //       type: type,
  //       seasons: seasons ?? this.seasons,
  //       voices: voices ?? this.voices,
  //       seasonCount: seasonCount,
  //       // bookmarked: bookmarked,
  //       // subtitles: subtitles,
  //       // voice: voice ?? this.voice,
  //       // quality: quality,
  //     );

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  /// является ли текущий элемент "директорией"
  @ignore
  bool get isFolder => (type == MediaItemType.folder);

  /// является ли текущий элемент "сериалом"
  @ignore
  bool get isShow => (type == MediaItemType.show);

  /// заблокирован ли контент правообладателем
  @ignore
  bool get blocked => false;

  /// продолжительность для информации
  String overviewDuration(BuildContext context) {
    switch (type) {
      case MediaItemType.folder:
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
  loadDetails(Ref ref) => throw UnimplementedError();

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
  MediaItem findSaved(KrsStorage storage) {
    final savedItem = storage.db.mediaItems.get(isarId);
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
  void save(KrsStorage storage) {
    storage.db.write((isar) {
      isar.mediaItems.put(this);
    });
  }

  /// образец экземпляра для показа индикатора загрузки
  factory MediaItem.skeleton() => MediaItem(
        title: 'Item title for skeleton',
        overview:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rhoncus suscipit nisi et convallis. Morbi ex libero, mollis mattis scelerisque ut, vulputate lacinia ligula ligu',
        genres: ['Lorem', 'Ipsum'],
        year: 'Lorem ip',
        countries: ['Lorem ipsum', 'Dolor sit amet'],
      );
}

//
// @JsonSerializable(explicitToJson: true)
// @collection
// class MediaItem {
//   @Id()
//   String get isarId => '${onlineService.name}|$id';
//
//   /// название онлайн-сервиса
//   final OnlineService onlineService;
//
//   /// тип контента
//   // @JsonKey(includeFromJson: false)
//   MediaItemType type;
//
//   /// идентификатор на сервисе
//   @StringConverter()
//   final String id;
//
//   /// название
//   final String title;
//
//   /// оригинальное название
//   @ignore
//   final String originalTitle;
//
//   /// описание
//   @ignore
//   final String overview;
//
//   /// постер
//   final String poster;
//
//   /// год
//   @StringConverter()
//   @ignore
//   final String year;
//
//   /// жанры
//   @ignore
//   final List<String> genres;
//
//   /// страны
//   @ignore
//   final List<String> countries;
//
//   /// варианты озвучки
//   @ignore
//   List<VoiceActing> voices;
//
//   /// рейтинг IMDb
//   @DoubleConverter()
//   @ignore
//   final double imdbRating;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @ignore
//   bool get hasImdbRating => imdbRating > 0.0;
//
//   /// рейтинг Кинопоиск
//   @DoubleConverter()
//   @ignore
//   final double kinopoiskRating;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @ignore
//   bool get hasKinopoiskRating => kinopoiskRating > 0.0;
//
//   /// сезоны
//   @ignore
//   List<MediaItemSeason> seasons = [];
//
//   /// дата добавления в закладки
//   DateTime? bookmarked;
//
//   /// включены или выключены субтитры
//   bool subtitles;
//
//   /// выбранная озвучка
//   VoiceActing voice;
//
//   /// выбранное качество видео
//   String quality;
//
//   MediaItem({
//     required this.id,
//     required this.title,
//     this.originalTitle = '',
//     this.overview = '',
//     this.poster = '',
//     this.year = '',
//     this.genres = const [],
//     this.countries = const [],
//     this.voices = const [],
//     this.imdbRating = 0.0,
//     this.kinopoiskRating = 0.0,
//     this.seasons = const [],
//     this.type = MediaItemType.unknown,
//     this.onlineService = OnlineService.none,
//
//     ///
//     this.bookmarked,
//     this.subtitles = false,
//     this.voice = const VoiceActing(),
//     this.quality = '',
//   });
//
//   factory MediaItem.fromJson(Map<String, dynamic> json) =>
//       _$MediaItemFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MediaItemToJson(this);
//
//   /// заблокирован ли контент правообладателем
//   @ignore
//   bool get blocked => false;
//
//   /// изображение на фон
//   String get backdrop => poster;
//
//   /// усреднённый рейтинг
//   @ignore
//   double get averageRating {
//     int ratingsCount = 0;
//     if (hasImdbRating) {
//       ratingsCount++;
//     }
//
//     if (hasKinopoiskRating) {
//       ratingsCount++;
//     }
//
//     if (ratingsCount == 0) {
//       return 0.0;
//     }
//
//     return (imdbRating + kinopoiskRating) / ratingsCount;
//   }
//
//   /// отображаемый рейтинг
//   @ignore
//   String get ratingStars {
//     if (averageRating == 0.0) {
//       return '';
//     } else if (averageRating < 5.0) {
//       return '☆☆☆';
//     } else if (averageRating < 6.0) {
//       return '★☆☆';
//     } else if (averageRating < 7.7) {
//       return '★★☆';
//     } else {
//       return '★★★';
//     }
//   }
//
//   @ignore
//   bool get isFolder => type == MediaItemType.folder;
//
//   /// загрузка подробных данных о сериале или фильме
//   Future<MediaItem> loadDetails(Ref ref) {
//     throw UnimplementedError();
//   }
//
//   /// загрузка эпизода
//   Future<MediaItemUrl> loadEpisodeUrl({
//     required WidgetRef ref,
//     required int episodeIndex,
//   }) {
//     throw UnimplementedError();
//   }
//
//   /// общий список всех эпизодов
//   List<MediaItemEpisode> episodes() {
//     return seasons.expand((season) => season.episodes).toList();
//   }
//
//   /// сохранение в базу данных
//   void save(KrsStorage storage) {
//     storage.db.write((isar) {
//       isar.mediaItems.put(this);
//     });
//   }
//
//   MediaItem? findSaved(KrsStorage storage) {
//     final savedItem = storage.db.mediaItems.get(isarId);
//     if (savedItem != null) {
//       switch (savedItem.onlineService) {
//         case OnlineService.none:
//           return savedItem;
//         case OnlineService.filmix:
//           return FilmixItem.fromJson(savedItem.toJson());
//         case OnlineService.tskg:
//           return TskgItem.fromJson(savedItem.toJson());
//       }
//     }
//
//     return null;
//   }
//
//   /// продолжительность для информации
//   String overviewDuration(BuildContext context) {
//     final locale = KrsLocale.of(context);
//     switch (type) {
//       case MediaItemType.unknown:
//       case MediaItemType.folder:
//         return '';
//       case MediaItemType.show:
//         return seasons.length > 1
//             ? locale.seasonsCount(seasons.length)
//             : locale.episodesCount(episodes().length);
//       case MediaItemType.movie:
//         return Duration(
//                 seconds:
//                     seasons.firstOrNull?.episodes.firstOrNull?.duration ?? 0)
//             .formatted;
//     }
//   }
//
//   MediaItem copyWith({String? id, VoiceActing? voice}) => MediaItem(
//         id: id ?? this.id,
//         title: title,
//         originalTitle: originalTitle,
//         overview: overview,
//         poster: poster,
//         year: year,
//         genres: genres,
//         countries: countries,
//         voices: voices,
//         imdbRating: imdbRating,
//         kinopoiskRating: kinopoiskRating,
//         seasons: seasons,
//         type: type,
//         onlineService: onlineService,
//         bookmarked: bookmarked,
//         subtitles: subtitles,
//         voice: voice ?? this.voice,
//         quality: quality,
//       );
//
//   factory MediaItem.skeleton() => MediaItem(
//         id: '',
//         title: 'Item title for skeleton',
//         overview:
//             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin rhoncus suscipit nisi et convallis. Morbi ex libero, mollis mattis scelerisque ut, vulputate lacinia ligula ligu',
//         genres: ['Lorem', 'Ipsum'],
//         year: 'Lorem ip',
//         countries: ['Lorem ipsum', 'Dolor sit amet'],
//       );
//
// // Stream<MediaItem?> dbStream(KrsStorage storage) {
// //   return storage.db.mediaItems.watchObject(id);
// // }
// }
