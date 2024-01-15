import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/tskg_api_provider.dart';
import '../../extensions/json_converters.dart';
import '../media_item.dart';
import '../media_item_url.dart';

part 'tskg_item.g.dart';

@JsonSerializable(explicitToJson: true)
class TskgItem extends MediaItem {
  TskgItem({
    super.id,
    super.title,
    super.type = MediaItemType.show,
    super.overview,
    super.year,
    super.genres,
    super.countries,
    super.seasonCount,
    super.imdbRating,
    super.kinopoiskRating,
    super.voiceActing,
    super.voices,
  });

  factory TskgItem.fromJson(Map<String, dynamic> json) =>
      _$TskgItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TskgItemToJson(this);

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
  Future<MediaItem> loadDetails(Ref ref) async {
    final api = ref.read(tskgApiProvider);

    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = api.getCancelToken();
    ref.onDispose(cancelToken.cancel);

    /// отправляем запрос на получение данных
    final detailedItem = await api.getDetails(
      showId: id,
      cancelToken: cancelToken,
    );

    detailedItem.subtitlesEnabled = subtitlesEnabled;
    detailedItem.bookmarked = bookmarked;

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
