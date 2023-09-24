import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';
import '../enums/online_service.dart';
import '../resources/krs_storage.dart';
import 'media_item_episode.dart';
import 'media_item_season.dart';
import 'voice_acting.dart';

export 'media_item_season.dart';
export 'media_item_episode.dart';

part 'media_item.g.dart';

@JsonSerializable(explicitToJson: true)
@collection
class MediaItem {
  @Id()
  String get isarDb => '$title$id';

  @StringConverter()
  final String id;

  final String title;
  final String originalTitle;
  final String overview;
  final String poster;

  @StringConverter()
  final String year;
  final List<String> genres;
  final List<String> countries;

  /// тип контента
  @JsonKey(includeFromJson: false)
  MediaItemType type;

  /// озвучка
  VoiceActing voiceActing;

  /// варианты озвучки
  List<VoiceActing> voiceActings;

  /// включены или выключены субтитры
  bool subtitlesEnabled;

  /// дата добавления в закладки
  DateTime? bookmarked;

  /// рейтинг IMDb
  @DoubleConverter()
  final double imdbRating;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasImdbRating => imdbRating > 0.0;

  /// рейтинг Кинопоиск
  @DoubleConverter()
  final double kinopoiskRating;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasKinopoiskRating => kinopoiskRating > 0.0;

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
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  OnlineService get onlineService => OnlineService.none;

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

  List<MediaItemEpisode> episodes() {
    return seasons.expand((season) => season.episodes).toList();
  }

  Future<void> save(KrsStorage storage) async {
    storage.db.write((isar) async {
      // if (seenEpisodes.isNotEmpty) {
      //   storage.db.episodeItems.putAllSync(seenEpisodes.toList());
      // }
      isar.mediaItems.put(this);
      //seenEpisodes.saveSync();
    });
  }

  // Stream<MediaItem?> dbStream(KrsStorage storage) {
  //   return storage.db.mediaItems.watchObject(id);
  // }
}

enum MediaItemType {
  none,
  show,
  movie,
}
