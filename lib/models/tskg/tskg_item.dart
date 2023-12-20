import '../media_item.dart';

class TskgItem extends MediaItem {
  TskgItem({
    super.id,
    super.title,
    super.genres,
    super.countries,
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
}
