import 'package:flutter/material.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';

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

  final storage = KikaStorage(
    sharedStorage: sharedStorage,
    secureStorage: secureStorage,
    db: dbStorage,
  );

  final mediaKitEnabled =
      storage.readBool('media_kit_enabled', defaultValue: false);
  VideoPlayerMediaKit.ensureInitialized(android: mediaKitEnabled);

  runApp(ProviderScope(
    overrides: [
      /// регистрируем [IuiStorage]
      storageProvider.overrideWithValue(storage),

      /// регистрируем [Device]
      deviceProvider.overrideWithValue(device),
    ],
    child: const App(),
  ));
}
