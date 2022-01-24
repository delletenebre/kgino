import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';

class Tskg {
  static String getPosterUrl(String showId) {
    final url = TskgApi.getUri('/posters/$showId.png');
    return url.toString();
  }

  static String getShowUrl(String showId) {
    final url = TskgApi.getUri('/show/$showId');
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

  /// неизвестно
  unknown,
}