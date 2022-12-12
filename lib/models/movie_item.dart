import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';

import 'episode_item.dart';
import 'season_item.dart';

part 'movie_item.g.dart';

@HiveType(typeId: 7)
enum MovieItemType {
  @HiveField(0) ockg,
  @HiveField(1) tskg,
  @HiveField(2) wcam,
  @HiveField(3) folder,
}

@HiveType(typeId: 11)
class MovieItem extends HiveObject with EquatableMixin {
  
  /// идентификатор сайта
  @HiveField(0) final MovieItemType type;
  
  /// идентификатор фильма или сериала
  @HiveField(1) final String id;

  /// название фильма или сериала
  @HiveField(2) final String name;

  /// постер фильма или сериала
  @HiveField(3) String posterUrl;

  /// включены или выключены субтитры
  @HiveField(4) bool subtitlesEnabled;

  /// включены или выключены субтитры
  @HiveField(5) bool favorite;

  /// дата последнего просмотра
  @HiveField(6) DateTime updatedAt;

  /// список просмотренных эпизодов
  @HiveField(7) List<EpisodeItem> episodes;

  /// список сезонов
  List<SeasonItem> seasons;

  /// оригинальное название
  final String originalName;
  
  /// описание фильма или сериала
  final String description;
  
  /// год выхода в прокат
  final String year;

  /// жанры
  final List<String> genres;

  /// страны
  final List<String> countries;

  
  /// ключ, по которому сохраняем в БД
  String get storageKey => '$type.$id';

  /// количество эпизодов во всех сезонах
  int get episodeCount => seasons.fold(0, (previousValue, season) {
    return previousValue + season.episodes.length;
  });

  MovieItem({
    required this.type,
    required this.id,
    required this.name,
    required this.posterUrl,

    this.subtitlesEnabled = false,
    this.favorite = false,
    DateTime? updatedAt,

    List<EpisodeItem>? episodes,
    this.seasons = const [],

    this.originalName = '',
    this.description = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
  }) : updatedAt = updatedAt ?? DateTime.now(),
        episodes = episodes ?? List<EpisodeItem>.empty(growable: true);
  
  @override
  List<Object> get props => [type, id];

  Future<PaletteGenerator> getPaletteGenerator() async {
    if (posterUrl.isNotEmpty) {
      return PaletteGenerator.fromImageProvider(
        NetworkImage(posterUrl)
      );
    }

    return PaletteGenerator.fromColors([PaletteColor(Color(0xff000000), 1)]);
  }
  
}


mixin TskgMovieItemMixin {
  String get voiceActing;
  List<MovieItem> get voiceActings;
}

mixin WithRatings on MovieItem {
  /// рейтинг IMDb
  late double _ratingImdb;
  double get ratingImdb => _ratingImdb;
  bool get hasImdbRating => ratingImdb > 0.0;

  /// рейтинг Кинопоиск
  late double _ratingKinopoisk;
  double get ratingKinopoisk => _ratingKinopoisk;
  bool get hasKinopoiskRating => ratingKinopoisk > 0.0;
}

mixin WithSixChannels on MovieItem {
  /// аудио информация о наличии звуковой дорожки 5.1
  late bool _hasSixChannels;
  bool get hasSixChannels => _hasSixChannels;
}

class TskgMovieItem extends MovieItem {
  
  /// текущая озвучка
  final String voiceActing;

  /// список доступных озвучек
  final List<MovieItem> voiceActings;
  
  TskgMovieItem({
    required String id,
    required String name,
    List<SeasonItem> seasons = const [],

    DateTime? updatedAt,

    String originalName = '',
    String description = '',
    String year = '',
    List<String> genres = const [],
    List<String> countries = const [],
    
    this.voiceActing = '',
    this.voiceActings = const [],
  }) : super(
    type: MovieItemType.tskg,
    id: id,
    name: name,
    posterUrl: 'https://www.ts.kg/posters/$id.png',
    seasons: seasons,

    updatedAt: updatedAt,
    
    originalName: originalName,
    description: description,
    year: year,
    genres: genres,
    countries: countries,
    
  );
  
}


class OckgMovieItem extends MovieItem with WithRatings, WithSixChannels {
  
  OckgMovieItem({
    required String id,
    required String name,
    required String posterUrl,
    required List<SeasonItem> seasons,

    String originalName = '',
    String description = '',
    String year = '',
    List<String> genres = const [],
    List<String> countries = const [],

    /// implement WithRatings
    double ratingImdb = 0.0,
    double ratingKinopoisk = 0.0,

    /// implement WithSixChannels
    bool hasSixAudioChannels = false,
  }) : super(
    type: MovieItemType.ockg,
    id: id,
    name: name,
    posterUrl: posterUrl,
    seasons: seasons,

    originalName: originalName,
    description: description,
    year: year,
    genres: genres,
    countries: countries,
    
  ) {
    /// implement WithRatings
    _ratingImdb = ratingImdb;
    _ratingKinopoisk = ratingKinopoisk;

    /// implement WithSixChannels
    _hasSixChannels = hasSixAudioChannels;
  }
}
