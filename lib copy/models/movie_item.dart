import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';

import 'episode_item.dart';
import 'season_item.dart';

part 'movie_item.g.dart';

@HiveType(typeId: 7)
enum ServiceName {
  ockg,
  tskg,
  wcam,
  flmx,
}

enum ItemType {
  movie,
  show,
  folder,
}

@HiveType(typeId: 11)
class MovieItem extends HiveObject with EquatableMixin {
  
  /// идентификатор сайта
  @HiveField(0) final ServiceName type;
  
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

  /// текущая озвучка
  @HiveField(8) String voiceActing;

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

  /// дополнительная информация (в основном вторая строка, после названия)
  final String subtitle;
  
  /// ключ, по которому сохраняем в БД
  String get storageKey => '$type.$id';

  /// количество эпизодов во всех сезонах
  int get episodeCount => seasons.fold(0, (previousValue, season) {
    return previousValue + season.episodes.length;
  });

  /// рейтинг IMDb
  final double ratingImdb;
  bool get hasImdbRating => ratingImdb > 0.0;

  /// рейтинг Кинопоиск
  final double ratingKinopoisk;
  bool get hasKinopoiskRating => ratingKinopoisk > 0.0;

  /// продолжительность
  final Duration duration;

  /// список доступных озвучек
  final List<MovieItem> voiceActings;

  /// аудио информация о наличии звуковой дорожки 5.1
  final bool hasSixChannels;


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
    this.subtitle = '',

    this.ratingImdb = 0.0,
    this.ratingKinopoisk = 0.0,

    this.duration = Duration.zero,

    this.voiceActing = '',
    this.voiceActings = const [],

    this.hasSixChannels = false,

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

    return PaletteGenerator.fromColors([PaletteColor(const Color(0xff000000), 1)]);
  }


  /// получаем последний просмотренный эпизод
  EpisodeItem? getLastSeenEpisode() {
    if (episodes.isNotEmpty) {
      episodes.sort((a, b) {
        return b.updatedAt.compareTo(a.updatedAt);
      });
      
      return episodes.first;
    }

    return null;
  }

  
  /// список всех эпизодов в сериале
  List<EpisodeItem> getAllEpisodes() {
    final episodes = <EpisodeItem>[];
    for (final season in seasons) {
      episodes.addAll(season.episodes);
    }
    return episodes;
  }


  /// получаем эпизод, с которого необходимо продолжить просмотр
  EpisodeItem getNextPlayableEpisode(EpisodeItem lastSeenEpisode) {
    /// получаем список эпизодов
    final episodes = getAllEpisodes();

    EpisodeItem playableEpisode = lastSeenEpisode;

    final episodeIndex = episodes.indexOf(lastSeenEpisode);
    if (episodeIndex > -1) {
      playableEpisode = episodes.elementAt(episodeIndex);
      playableEpisode.position = lastSeenEpisode.position;

      if (playableEpisode.isSeen && episodeIndex < episodes.length - 1) {
        playableEpisode = episodes.elementAt(episodeIndex + 1);
      }
    }
    
    return playableEpisode;
  }


  factory MovieItem.webcamera({
    required String name,
    required String posterUrl,
    required String videoFileUrl,
  }) => MovieItem(
    type: ServiceName.wcam,
    id: '',
    name: name,
    posterUrl: posterUrl,
    seasons: [
      SeasonItem(
        name: '',
        episodes: [
          EpisodeItem(
            id: '',
            name: '',
            videoFileUrl: videoFileUrl
          ),
        ],
      ),
    ],
  );
  
}

class TskgMovieItem extends MovieItem {
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
    String subtitle = '',
    
    super.voiceActing,
    super.voiceActings,
  }) : super(
    type: ServiceName.tskg,
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
    subtitle: subtitle,
    
  );
  
}


class OckgMovieItem extends MovieItem {
  
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
    type: ServiceName.ockg,
    id: id,
    name: name,
    posterUrl: posterUrl,
    seasons: seasons,

    originalName: originalName,
    description: description,
    year: year,
    genres: genres,
    countries: countries,

    ratingImdb: ratingImdb,
    ratingKinopoisk: ratingKinopoisk,

    duration: seasons.first.episodes.length == 1
      ? Duration(seconds: seasons.first.episodes.first.duration)
      : Duration.zero,

    hasSixChannels: hasSixAudioChannels,
  );
}
