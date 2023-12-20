import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'media_item.freezed.dart';
part 'media_item.g.dart';

/// онлайн-сервисы
enum OnlineService {
  none,
  filmix,
  tskg,
}

/// тип медиа-контента
enum MediaItemType {
  show,
  movie,
  folder,
}

abstract interface class Database {
  @Id()
  String get dbId;

  /// онлайн-сервис
  OnlineService get onlineService;

  /// идентификатор на сервисе
  String get id;

  /// название
  String get title;
}

abstract interface class Playable {
  String getPlayableUrl();
}

@freezed
@Collection(ignore: {'copyWith'})
class MediaItem with _$MediaItem implements Database {
  const MediaItem._();

  // const factory MediaItem({
  //   /// онлайн-сервис
  //   @Default(OnlineService.none) OnlineService onlineService,
  //
  //   /// идентификатор на сервисе
  //   @Default('') String id,
  //
  //   /// название
  //   @Default('') String title,
  //
  //   /// постер
  //   @Default('') String poster,
  //
  //   /// описание (не сохраняем в базе данных)
  //   @ignore @Default('') String overview,
  // }) = _MediaItem;

  @Implements<Database>()
  const factory MediaItem.tskg(String id, String title) = TskgItem;

  @Implements<Database>()
  const factory MediaItem.filmix(String id, String title) = FilmixItem;

  factory MediaItem.fromJson(Map<String, Object?> json) =>
      _$MediaItemFromJson(json);

  @override
  @Id()
  String get dbId => '$onlineService|$id';

  @override
  String get id => id;

  @override
  String get title => title;

  @override
  OnlineService get onlineService {
    if (this is TskgItem) {
      return OnlineService.tskg;
    } else if (this is FilmixItem) {
      return OnlineService.filmix;
    }

    return OnlineService.none;
  }

  // @override
  // String getPlayableUrl() {
  //   if (this is TskgItem) {
  //     return '2';
  //   }
  //   return '1';
  // }
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
