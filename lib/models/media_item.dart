import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';
import '../enums/online_service.dart';
import '../resources/krs_storage.dart';
import 'filmix/filmix_item.dart';
import 'media_item_episode.dart';
import 'media_item_season.dart';
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
  String get isarId => '$onlineService|$id';

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

  /// выбранная озвучка
  VoiceActing voiceActing;

  /// варианты озвучки
  @ignore
  List<VoiceActing> voiceActings;

  /// включены или выключены субтитры
  bool subtitlesEnabled;

  /// дата добавления в закладки
  DateTime? bookmarked;

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

  MediaItem({
    required this.id,
    required this.title,
    this.originalTitle = '',
    this.overview = '',
    required this.poster,
    this.year = '',
    this.genres = const [],
    this.countries = const [],
    this.voiceActing = const VoiceActing(),
    this.voiceActings = const [],
    this.subtitlesEnabled = false,
    this.imdbRating = 0.0,
    this.kinopoiskRating = 0.0,
    this.seasons = const [],
    this.bookmarked,
    this.type = MediaItemType.none,
    this.onlineService = OnlineService.none,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  /// изображение на фон
  String get backdrop => poster;

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
    storage.db.write((isar) async {
      // if (seenEpisodes.isNotEmpty) {
      //   storage.db.episodeItems.putAllSync(seenEpisodes.toList());
      // }
      isar.mediaItems.put(this);
      //seenEpisodes.saveSync();
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
      }
    }
  }

  // Stream<MediaItem?> dbStream(KrsStorage storage) {
  //   return storage.db.mediaItems.watchObject(id);
  // }
}
