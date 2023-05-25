// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/episode_item.dart';
import '../models/kgino_item.dart';

class KrsStorage {
  late final SharedPreferences sharedStorage;
  // final FlutterSecureStorage secureStorage;
  late final Isar db;

  KrsStorage();

  Future<KrsStorage> initialize() async {

    /// инициализируем локальное хранилище
    sharedStorage = await SharedPreferences.getInstance();

    /// инициализируем базу данных
    db = await Isar.open([
      KginoItemSchema,
      EpisodeItemSchema,
    ], directory: '');

    return this;
  }


  /// чтение данных из обычного хранилища
  String read(String key, { String defaultValue = '' }) {
    return sharedStorage.getString(key) ?? defaultValue;
  }

  // /// чтение данных из защищённого хранилища
  // Future<String> readSecure(String key, { String defaultValue = '' }) async {
  //   return (await secureStorage.read(key: key)) ?? defaultValue;
  // }

  /// запись данных в обычное хранилище
  Future<void> write(String key, String value) async {
    sharedStorage.setString(key, value);
  }

  // /// запись данных в защищённое хранилище
  // Future<void> writeSecure(String key, dynamic value) async {
  //   if (value is Map) {
  //     value = json.encode(value);
  //   } else {
  //     value = value.toString();
  //   }

  //   // TODO its bug
  //   await removeSecure(key);
  //   await secureStorage.write(key: key, value: value);
  // }

  /// удаляем данные из обычного хранилища
  Future<void> remove(String key) async {
    sharedStorage.remove(key);
  }

  // /// удаляем данные из защищённого хранилища
  // Future<void> removeSecure(String key) async {
  //   secureStorage.delete(key: key);
  // }
  
}