import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extensions/json_converters.dart';
import 'media_item_season.dart';

part 'media_item.g.dart';

@JsonSerializable(explicitToJson: true)
class MediaItem {
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

  /// озвучка
  String voiceActing;

  /// варианты озвучки
  Map<String, String> voiceActings;

  /// включены или выключены субтитры
  bool subtitlesEnabled;

  /// дата добавления в список закладок
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
    this.id = '',
    this.title = '',
    this.originalTitle = '',
    this.overview = '',
    this.poster = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
    this.voiceActing = '',
    this.voiceActings = const {},
    this.subtitlesEnabled = false,
    this.bookmarked,
    this.imdbRating = 0.0,
    this.kinopoiskRating = 0.0,
    this.seasons = const [],
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);

  String get backdrop => poster;

  /// загрузка подробных данных о сериале или фильме
  Future<MediaItem> loadDetails(Ref ref) {
    throw UnimplementedError();
  }

  /// загрузка эпизода
  Future<String> loadEpisodeUrl({
    required WidgetRef ref,
    required int seasonIndex,
    required int episodeIndex,
  }) {
    throw UnimplementedError();
  }
}
