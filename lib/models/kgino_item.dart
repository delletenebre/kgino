import 'package:isar/isar.dart';

import 'episode_item.dart';
import 'season_item.dart';

part 'kgino_item.g.dart';

enum KginoProvider {
  ockg,
  tskg,
  wcam,
  flmx,
}

enum KginoItemType {
  movie,
  show,
  folder,
}

@collection
class KginoItem {

  Id get isarId => fastHash(storageKey);

  /// ключ, по которому сохраняем в БД
  String get storageKey => '$provider.$id';
  
  /// тип контента
  @enumerated
  final KginoItemType type;

  /// идентификатор сервиса
  @enumerated
  final KginoProvider provider;
  
  /// идентификатор фильма или сериала
  final String id;

  /// название фильма или сериала
  final String name;

  /// постер фильма или сериала
  final String posterUrl;

  /// включены или выключены субтитры
  bool subtitlesEnabled;

  /// включены или выключены субтитры
  bool favorite;

  /// дата последнего просмотра
  DateTime updatedAt;

  /// список просмотренных эпизодов
  final episodes = IsarLinks<EpisodeItem>();

  /// текущая озвучка
  String voiceActing;

  /// список сезонов
  @ignore
  List<SeasonItem> seasons;

  /// оригинальное название
  @ignore
  final String originalName;
  
  /// описание фильма или сериала
  @ignore
  final String description;
  
  /// год выхода в прокат
  @ignore
  final String year;

  /// жанры
  @ignore
  final List<String> genres;

  /// страны
  @ignore
  final List<String> countries;

  /// дополнительная информация (в основном вторая строка, после названия)
  @ignore
  final String subtitle;
  
  /// количество эпизодов во всех сезонах
  int get episodeCount => seasons.fold(0, (previousValue, season) {
    return previousValue + season.episodes.length;
  });

  /// рейтинг IMDb
  @ignore
  final double imdbRating;
  bool get hasImdbRating => imdbRating > 0.0;

  /// рейтинг Кинопоиск
  @ignore
  final double kinopoiskRating;
  bool get hasKinopoiskRating => kinopoiskRating > 0.0;

  /// продолжительность
  @ignore
  final Duration duration;

  /// список доступных озвучек
  @ignore
  final List<KginoItem> voiceActings;

  /// аудио информация о наличии звуковой дорожки 5.1
  @ignore
  final bool hasSixChannels;


  KginoItem({
    required this.type,
    required this.provider,
    required this.id,
    required this.name,
    required this.posterUrl,

    this.subtitlesEnabled = false,
    this.favorite = false,
    required this.updatedAt,

    this.seasons = const [],

    this.originalName = '',
    this.description = '',
    this.year = '',
    this.genres = const [],
    this.countries = const [],
    this.subtitle = '',

    this.imdbRating = 0.0,
    this.kinopoiskRating = 0.0,

    this.duration = Duration.zero,

    this.voiceActing = '',
    this.voiceActings = const [],

    this.hasSixChannels = false,

  }); //: episodes = episodes ?? List<EpisodeItem>.empty(growable: true);

  /// получаем последний просмотренный эпизод
  EpisodeItem? getLastSeenEpisode() {
    if (episodes.isNotEmpty) {
      episodes.toList().sort((a, b) {
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


  // factory KginoItem.webcamera({
  //   required String name,
  //   required String posterUrl,
  //   required String videoFileUrl,
  // }) => KginoItem(
  //   type: KginoItemType.movie,
  //   provider: KginoProvider.wcam,
  //   id: '',
  //   name: name,
  //   posterUrl: posterUrl,
  //   seasons: [
  //     SeasonItem(
  //       name: '',
  //       episodes: [
  //         EpisodeItem(
  //           id: '',
  //           name: '',
  //           videoFileUrl: videoFileUrl
  //         ),
  //       ],
  //     ),
  //   ],
  // );
  
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
// class TskgMovieItem extends MovieItem {
//   TskgMovieItem({
//     required String id,
//     required String name,
//     List<SeasonItem> seasons = const [],

//     DateTime? updatedAt,

//     String originalName = '',
//     String description = '',
//     String year = '',
//     List<String> genres = const [],
//     List<String> countries = const [],
//     String subtitle = '',
    
//     super.voiceActing,
//     super.voiceActings,
//   }) : super(
//     type: ServiceName.tskg,
//     id: id,
//     name: name,
//     posterUrl: 'https://www.ts.kg/posters/$id.png',
//     seasons: seasons,

//     updatedAt: updatedAt,
    
//     originalName: originalName,
//     description: description,
//     year: year,
//     genres: genres,
//     countries: countries,
//     subtitle: subtitle,
    
//   );
  
// }


// class OckgMovieItem extends MovieItem {
  
//   OckgMovieItem({
//     required String id,
//     required String name,
//     required String posterUrl,
//     required List<SeasonItem> seasons,

//     String originalName = '',
//     String description = '',
//     String year = '',
//     List<String> genres = const [],
//     List<String> countries = const [],

//     /// implement WithRatings
//     double ratingImdb = 0.0,
//     double ratingKinopoisk = 0.0,

//     /// implement WithSixChannels
//     bool hasSixAudioChannels = false,
//   }) : super(
//     type: ServiceName.ockg,
//     id: id,
//     name: name,
//     posterUrl: posterUrl,
//     seasons: seasons,

//     originalName: originalName,
//     description: description,
//     year: year,
//     genres: genres,
//     countries: countries,

//     ratingImdb: ratingImdb,
//     ratingKinopoisk: ratingKinopoisk,

//     duration: seasons.first.episodes.length == 1
//       ? Duration(seconds: seasons.first.episodes.first.duration)
//       : Duration.zero,

//     hasSixChannels: hasSixAudioChannels,
//   );
// }
