import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../api/rezka_api_provider.dart';
import '../media_item.dart';
import '../media_item_url.dart';

class RezkaItem extends MediaItem {
  RezkaItem({
    required super.id,
    required super.title,
    super.countries,
    super.genres = const [],
    super.imdbRating,
    super.kinopoiskRating,
    super.onlineService = OnlineService.rezka,
    super.originalTitle = '',
    super.overview = '',
    super.poster,
    super.seasonCount,
    super.seasons,
    super.type = MediaItemType.show,
    super.voices,
    super.year,

    ///
    super.blockedStatus,
    super.bookmarked,
    super.quality = '720p',
    super.subtitlesEnabled,
    super.voiceActing,
  });

  factory RezkaItem.fromJson(Map<String, dynamic> json) {
    final mediaItem = MediaItem.fromJson(json);
    return RezkaItem(
      id: mediaItem.id,
      title: mediaItem.title,
      countries: mediaItem.countries,
      genres: mediaItem.genres,
      imdbRating: mediaItem.imdbRating,
      kinopoiskRating: mediaItem.kinopoiskRating,
      onlineService: OnlineService.rezka,
      originalTitle: mediaItem.originalTitle,
      overview: mediaItem.overview,
      poster: mediaItem.poster,
      seasonCount: mediaItem.seasonCount,
      seasons: mediaItem.seasons,
      type: mediaItem.type,
      voices: mediaItem.voices,
      year: mediaItem.year,

      ///
      blockedStatus: mediaItem.blockedStatus,
      bookmarked: mediaItem.bookmarked,
      quality: mediaItem.quality,
      subtitlesEnabled: mediaItem.subtitlesEnabled,
      voiceActing: mediaItem.voiceActing,
    );
  }

  // /// извлекаем идентификатор сериала из ссылки
  // static String getShowIdFromUrl(String url) {
  //   // разделяем url по '/'
  //   final path = url.split('/');

  //   if (url.startsWith('/show') && path.length > 1) {
  //     /// ^ если url похож на ссылку сериала

  //     /// идентификатор сериала должен быть третьим элементом в списке
  //     return path.elementAt(2);
  //   } else {
  //     /// ^ если url странный

  //     return '';
  //   }
  // }

  // /// формируем полную ссылку на постер сериала по id
  // @override
  // String get poster => overview.isNotEmpty
  //     ? 'https://www.ts.kg/posters2/$id.png'
  //     : 'https://www.ts.kg/posters/$id.png';

  // /// заблокирован ли контент правообладателем
  // @override
  // bool get blocked => false;

  // // @override
  // // List<String> get genres =>
  // //     categories..removeWhere((element) => element == 'Сериалы');

  /// загрузка подробных данных о сериале или фильме
  @override
  Future<MediaItem> loadDetails(Ref ref, CancelToken? cancelToken) async {
    final api = ref.read(rezkaApiProvider);

    /// отправляем запрос на получение данных
    final detailedItem = await api.getDetails(
      dbId: dbId,
      id: id,
      voiceActing: voiceActing,
      cancelToken: cancelToken,
    );

    detailedItem.quality = quality;
    detailedItem.subtitlesEnabled = subtitlesEnabled;
    detailedItem.bookmarked = bookmarked;

    await detailedItem.loadTmdb();

    return detailedItem;
  }

  /// получение списка сезонов
  @override
  Future<List<MediaItemSeason>> loadSeasons(Ref ref) async {
    /// отправляем запрос на получение данных
    return seasons;
  }

  /// получение списка вариантов озвучки
  @override
  Future<List<VoiceActing>> loadVoices(Ref ref) async {
    return voices;
  }

  /// получение ссылки на воспроизводимый файл
  @override
  Future<MediaItemUrl> loadEpisodeUrl(
      WidgetRef ref, MediaItemEpisode episode) async {
    /// идентификатор сериала
    final postId = episode.id.split('@').first.split('|').last.split('-').first;

    /// провайдер запросов к API
    final api = ref.read(rezkaApiProvider);

    if (type == MediaItemType.movie) {
      /// ссылку на фильм
      return await api.getMovieStream(
        id: postId,
        voiceActingId: voiceActing.id,
        quality: quality,
      );
    } else {
      /// получаем данные эпизода
      return await api.getStream(
        id: postId,
        voiceActingId: voiceActing.id,
        seasonId: episode.seasonNumber,
        episodeId: episode.episodeNumber,
        quality: quality,
      );
    }
  }
}
