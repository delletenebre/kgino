import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../api/tskg_api_provider.dart';
import '../media_item.dart';

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
  });

  @override
  get onlineService => OnlineService.tskg;

  /// формируем полную ссылку на постер сериала по id
  @override
  String get poster => overview.isNotEmpty
      ? 'https://www.ts.kg/posters2/$id.png'
      : 'https://www.ts.kg/posters/$id.png';

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

    // detailedItem.subtitles = subtitles;
    // detailedItem.bookmarked = bookmarked;

    return detailedItem;
  }
}
