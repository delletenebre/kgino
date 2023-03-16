import 'dart:convert';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KrsStorage {
  KrsStorage({
    required this.sharedStorage,
    // required this.secureStorage,
  });

  final SharedPreferences sharedStorage;
  // final FlutterSecureStorage secureStorage;

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