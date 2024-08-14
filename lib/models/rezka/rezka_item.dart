import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/rezka_api_provider.dart';
import '../../extensions/json_converters.dart';
import '../media_item.dart';
import '../media_item_url.dart';

part 'rezka_item.g.dart';

@JsonSerializable(explicitToJson: true)
class RezkaItem extends MediaItem {
  RezkaItem({
    super.onlineService = OnlineService.rezka,
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
    super.poster,
    super.type = MediaItemType.show,
    super.seasonCount,

    ///
    super.bookmarked,
    super.subtitlesEnabled,
    super.voiceActing,
    super.quality = '720p',
    super.blockedStatus,
  });

  factory RezkaItem.fromJson(Map<String, dynamic> json) =>
      _$RezkaItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RezkaItemToJson(this);

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

    final tmdb = await loadTmdb();
    detailedItem.tmdb = tmdb;

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
