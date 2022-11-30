//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/tskg/tskg_favorites_controller.dart';
import '../models/tskg/tskg_favorite.dart';
import '../models/tskg/tskg_seen_episode.dart';

class KrsStorage {
  KrsStorage({
    required this.sharedStorage,
    //required this.secureStorage,
  }) {
    Hive.registerAdapter(TskgFavoriteAdapter());
    Hive.openBox<TskgFavorite>(TskgFavoritesController.boxName);

    Hive.registerAdapter(TskgSeenEpisodeAdapter());
    Hive.openBox<TskgSeenEpisode>('tskg_seen');
  }

  final SharedPreferences sharedStorage;
  //final FlutterSecureStorage secureStorage;

  /// чтение данных из обычного хранилища
  String read(String key, { String defaultValue = '' }) {
    return sharedStorage.getString(key) ?? defaultValue;
  }

  /// запись данных в обычное хранилище
  Future<void> write(String key, String value) async {
    sharedStorage.setString(key, value);
  }

    /// удаляем данные из обычного хранилища
  Future<void> remove(String key) async {
    sharedStorage.remove(key);
  }

  /// чтение данных из защищённого хранилища
  // Future<String> readSecure(String key, { String defaultValue = '' }) async {
  //   return (await secureStorage.read(key: key)) ?? defaultValue;
  // }

  /// запись данных в защищённое хранилище
  // Future<void> writeSecure(String key, dynamic value) async {
  //   if (value is Map) {
  //     value = json.encode(value);
  //   } else {
  //     value = value.toString();
  //   }

  //   secureStorage.write(key: key, value: value);
  // }

  /// удаляем данные из защищённого хранилища
  // Future<void> removeSecure(String key) async {
  //   secureStorage.delete(key: key);
  // }
}
