import 'package:kgino/api/tskg/tskg_api.dart';

class Tskg {
  static String getPoster(String tvshowId) {
    final url = TskgApi.getUri('/posters/$tvshowId.png');
    return url.toString();
  }
}

enum TskgBagdeType {
  /// новое
  newest,

  /// топ
  top,

  /// обновлено
  updated,

  /// временно
  temporarily,

  /// финал
  finale,

  /// подборка
  compilation,

  /// важно
  important,

  /// новогоднее
  newyear,

}