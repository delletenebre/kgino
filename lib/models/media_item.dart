import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../extensions/json_converters.dart';

part 'media_item.g.dart';

/// онлайн-сервисы
enum OnlineService {
  none,
  filmix,
  tskg;

  String get logo {
    switch (this) {
      case OnlineService.tskg:
        return 'assets/images/tskg.svg';
      case OnlineService.filmix:
        return 'assets/images/filmix.svg';
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
  String getPlayableUrl();
}

@JsonSerializable(explicitToJson: true)
@collection
class MediaItem {
  /// идентификатор в базе данных
  @Id()
  String get isarId => '${onlineService.name}|$id';

  /// онлайн-сервис
  final OnlineService onlineService;

  /// идентификатор на сервисе
  @StringConverter()
  final String id;

  /// название
  final String title;

  /// постер
  final String poster;

  /// описание (не сохраняем в базе данных)
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

  const MediaItem({
    this.onlineService = OnlineService.none,
    this.id = '',
    this.title = '',
    this.poster = '',

    /// не в базе данных
    this.overview = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);
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
