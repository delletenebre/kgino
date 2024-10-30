import 'dart:convert';

import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KikaStorage {
  final SharedPreferences sharedStorage;
  final FlutterSecureStorage secureStorage;
  final Database db;

  KikaStorage({
    required this.sharedStorage,
    required this.secureStorage,
    required this.db,
  });

  final ValueNotifier<Map<String, dynamic>> _notifier = ValueNotifier({});
  ValueNotifier<Map<String, dynamic>> get notifier => _notifier;

  /// чтение данных из обычного хранилища
  String read(String key, {String defaultValue = ''}) {
    return sharedStorage.getString(key) ?? defaultValue;
  }

  /// чтение данных из обычного хранилища
  bool readBool(String key, {bool defaultValue = false}) {
    return sharedStorage.getBool(key) ?? defaultValue;
  }

  /// чтение данных из защищённого хранилища
  Future<String> readSecure(String key, {String defaultValue = ''}) async {
    return (await secureStorage.read(key: key)) ?? defaultValue;
  }

  /// запись данных в обычное хранилище
  Future<void> write(String key, dynamic value) async {
    if (value is bool) {
      sharedStorage.setBool(key, value);
    } else if (value is String) {
      sharedStorage.setString(key, value);
    }
    _notifyChange(key, value);
  }

  /// запись данных в защищённое хранилище
  Future<void> writeSecure(String key, dynamic value) async {
    if (value is Map) {
      value = json.encode(value);
    } else {
      value = value.toString();
    }

    // TODO its bug
    await removeSecure(key);
    await secureStorage.write(key: key, value: value);
  }

  /// удаляем данные из обычного хранилища
  Future<void> remove(String key) async {
    sharedStorage.remove(key);
  }

  /// удаляем данные из защищённого хранилища
  Future<void> removeSecure(String key) async {
    if (await secureStorage.containsKey(key: key)) {
      secureStorage.delete(key: key);
    }
  }

  void _notifyChange(String key, dynamic value) {
    _notifier.value = {..._notifier.value, key: value};
  }

  /// чтение списка из обычного хранилища
  List<T> readList<T>(String key, {dynamic defaultValue = const {}}) {
    late final String df;
    if (defaultValue is Map || defaultValue is List) {
      df = jsonEncode(defaultValue);
    } else {
      df = defaultValue;
    }

    return jsonDecode(sharedStorage.getString(key) ?? defaultValue);
  }

  /// запись списка в обычное хранилище
  void writeList<T>(String key, List<T> value) {
    final encoded = jsonEncode(value);
    sharedStorage.setString(key, encoded);
  }
}

class DatabaseEngine {
  static Future<Database> initialize() async {
    if (kIsWeb) {
      // Open the database
      return await databaseFactoryWeb.openDatabase('kgino');
    } else {
      // get the application documents directory
      final dir = await getApplicationDocumentsDirectory();
      // make sure it exists
      await dir.create(recursive: true);
      // build the database path
      final dbPath = join(dir.path, 'kgino.db');
      // open the database
      return await databaseFactoryIo.openDatabase(dbPath);
    }
  }
}
