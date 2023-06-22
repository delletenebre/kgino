// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/episode_item.dart';
import '../models/kgino_item.dart';

class KrsStorage {
  late final SharedPreferences sharedStorage;
  late final Isar db;

  KrsStorage();

  Future<KrsStorage> initialize() async {

    /// инициализируем локальное хранилище
    sharedStorage = await SharedPreferences.getInstance();

    Directory directory = Directory('/assets/db');
    if (!kIsWeb) {
      directory = await getApplicationDocumentsDirectory();
    }

    /// инициализируем базу данных
    // db = await Isar.open(
    //   [
    //     KginoItemSchema,
    //     EpisodeItemSchema,
    //   ],
    //   directory: directory.path,
    // );

    db = await Isar.open(
      schemas: [
        KginoItemSchema,
        EpisodeItemSchema,
      ],
      directory: directory.path,
    );

    return this;
  }

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
  
}