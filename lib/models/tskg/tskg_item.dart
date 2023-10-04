import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/tskg_api_provider.dart';
import '../../enums/online_service.dart';
import '../../extensions/json_converters.dart';
import '../media_item.dart';
import '../voice_acting.dart';

part 'tskg_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TskgItem extends MediaItem {
  // для последних добавленных
  DateTime? date;

  List<String> badges;

  TskgItem({
    required super.id,
    required super.title,
    super.originalTitle = '',
    super.overview = '',
    super.genres = const [],
    super.year,
    super.countries,
    super.imdbRating,
    super.kinopoiskRating,
    super.seasons,
    super.voices,
    super.onlineService = OnlineService.tskg,
    super.type = MediaItemType.show,
    this.date,
    this.badges = const [],

    ///
    super.bookmarked,
    super.subtitles,
    super.voice,
    super.quality = 0,
  });

  factory TskgItem.fromJson(Map<String, dynamic> json) =>
      _$TskgItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TskgItemToJson(this);

  /// извлекаем идентификатор сериала из ссылки
  static String getShowIdFromUrl(String url) {
    // разделяем url по '/'
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

  /// формируем полную ссылку на постер сериала по id
  @override
  String get poster => overview.isNotEmpty
      ? 'https://www.ts.kg/posters2/$id.png'
      : 'https://www.ts.kg/posters/$id.png';

  /// заблокирован ли контент правообладателем
  @override
  bool get blocked => false;

  // @override
  // List<String> get genres =>
  //     categories..removeWhere((element) => element == 'Сериалы');

  @override
  Future<MediaItem> loadDetails(Ref ref) async {
    final api = ref.read(tskgApiProvider);

    /// отменяем выполнение запроса, если страница закрыта
    final cancelToken = api.getCancelToken();
    ref.onDispose(cancelToken.cancel);

    final detailedItem = await api.getDetails(
      showId: id,
      cancelToken: cancelToken,
    );

    detailedItem.subtitles = subtitles;
    detailedItem.bookmarked = bookmarked;

    return detailedItem;
  }

  @override
  Future<MediaItemUrl> loadEpisodeUrl({
    required WidgetRef ref,
    required int episodeIndex,
  }) async {
    final episodes = this.episodes();

    final episode = episodes.elementAtOrNull(episodeIndex);
    if (episode != null) {
      final episodeId = episode.id.split('@')[1];

      /// провайдер запросов к API
      final api = ref.read(tskgApiProvider);

      /// получаем данные эпизода
      return await api.getEpisodePlayableUrl(episodeId);
    }

    return MediaItemUrl();
  }
}