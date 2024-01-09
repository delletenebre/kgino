import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/media_item.dart';

class KrsStorage {
  late final SharedPreferences sharedStorage;
  late final Isar db;

  late final String installationId;

  KrsStorage();

  Future<KrsStorage> initialize() async {
    /// инициализируем локальное хранилище
    sharedStorage = await SharedPreferences.getInstance();

    late final Directory directory;
    if (kIsWeb) {
      directory = Directory('/assets/db');
      await Isar.initialize();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    db = Isar.open(
      schemas: [
        MediaItemSchema,
        MediaItemEpisodeSchema,
      ],
      directory: kIsWeb ? Isar.sqliteInMemory : directory.path,
      engine: kIsWeb ? IsarEngine.sqlite : IsarEngine.isar,
      inspector: kDebugMode,
    );
    // } catch (exception) {}

    return this;
  }

  /// чтение данных из обычного хранилища
  String read(String key, {String defaultValue = ''}) {
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
