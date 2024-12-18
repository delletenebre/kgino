import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../api/tskg_api_provider.dart';
import '../media_item.dart';
import '../media_item_url.dart';

class TskgItem extends MediaItem {
  TskgItem({
    super.blockedStatus,
    super.countries,
    super.genres,
    super.id,
    super.imdbRating,
    super.kinopoiskRating,
    super.onlineService = OnlineService.tskg,
    super.originalTitle,
    super.overview,
    super.seasonCount,
    super.subtitlesEnabled,
    super.title,
    super.type = MediaItemType.show,
    super.voiceActing,
    super.voices,
    super.year,
  });

  factory TskgItem.fromJson(Map<String, dynamic> json) {
    final mediaItem = MediaItem.fromJson(json);
    return TskgItem(
      blockedStatus: mediaItem.blockedStatus,
      countries: mediaItem.countries,
      genres: mediaItem.genres,
      id: mediaItem.id,
      imdbRating: mediaItem.imdbRating,
      kinopoiskRating: mediaItem.kinopoiskRating,
      onlineService: OnlineService.tskg,
      originalTitle: mediaItem.originalTitle,
      overview: mediaItem.overview,
      seasonCount: mediaItem.seasonCount,
      subtitlesEnabled: mediaItem.subtitlesEnabled,
      title: mediaItem.title,
      type: mediaItem.type,
      voiceActing: mediaItem.voiceActing,
      voices: mediaItem.voices,
      year: mediaItem.year,
    );
  }

  @override
  get onlineService => OnlineService.tskg;

  /// формируем полную ссылку на постер сериала по id
  @override
  String get poster => overview.isNotEmpty
      ? '${TskgApi.baseUrl}/posters2/$id.png'
      : '${TskgApi.baseUrl}/posters/$id.png';

  /// извлекаем идентификатор сериала из ссылки
  static String getShowIdFromUrl(String url) {
    /// разделяем url по символу '/'
    final path = url.split('/');

    if (url.startsWith('/show') && path.length > 1) {
      /// ^ если url похож на ссылку сериала

      /// идентификатор сериала должен быть третьим элементом в списке
      return path.elementAt(2);
    } else {
      /// ^ если url странный

      return '';
    }
  }

  /// загрузка подробных данных о сериале или фильме
  @override
  Future<MediaItem> loadDetails(Ref ref, CancelToken? cancelToken) async {
    final api = ref.read(tskgApiProvider);

    /// отправляем запрос на получение данных
    final detailedItem =
        await api.getDetails(showId: id, cancelToken: cancelToken);

    detailedItem.subtitlesEnabled = subtitlesEnabled;
    detailedItem.bookmarked = bookmarked;

    await detailedItem.loadTmdb();

    return detailedItem;
  }

  /// получение списка сезонов
  @override
  Future<List<MediaItemSeason>> loadSeasons(Ref ref) async {
    final api = ref.read(tskgApiProvider);

    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = api.getCancelToken();
    ref.onDispose(cancelToken.cancel);

    /// отправляем запрос на получение данных
    return await api.getSeasons(
      showId: id,
      cancelToken: cancelToken,
    );
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
    /// провайдер запросов к API
    final api = ref.read(tskgApiProvider);

    /// идентификатор эпизода
    final episodeId = episode.id.split('@')[1];

    /// получаем данные эпизода
    final playableUrl = await api.getEpisodePlayableUrl(episodeId);

    await playableUrl.loadSubtitlesFile();

    return playableUrl;
  }
}
