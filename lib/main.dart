import 'package:flutter/material.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'models/device.dart';
import 'providers/device_provider.dart';
import 'providers/storage_provider.dart';
import 'resources/kika_storage.dart';

Future<void> main() async {
  /// ожидаем инициализации модуля взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  await langdetect.initLangDetect();

  /// информация об устройстве
  final device = await Device.initialize();

  /// инициализируем локальное хранилище
  final sharedStorage = await SharedPreferences.getInstance();

  /// инициализируем защищённое хранилище
  const secureStorage = FlutterSecureStorage();

  /// инициализируем базу данных
  final dbStorage = await DatabaseEngine.initialize();

  runApp(ProviderScope(
    overrides: [
      /// регистрируем [IuiStorage]
      storageProvider.overrideWithValue(
        KikaStorage(
          sharedStorage: sharedStorage,
          secureStorage: secureStorage,
          db: dbStorage,
        ),
      ),

      /// регистрируем [Device]
      deviceProvider.overrideWithValue(device),
    ],
    child: const App(),
  ));
}
