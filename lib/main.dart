import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

// import 'package:media_kit/media_kit.dart';

import 'app.dart';
import 'models/device_details.dart';
import 'providers/providers.dart';
import 'resources/krs_storage.dart';

Future<void> main() async {
  // debugRepaintRainbowEnabled = true;
  // debugPaintLayerBordersEnabled = true;

  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  /// инициализируем видеоплеер
  MediaKit.ensureInitialized();

  /// информация об устройстве
  final deviceDetails = await DeviceDetails.initialize();

  /// инициализируем хранилище
  final storage = await KrsStorage().initialize();

  runApp(ProviderScope(
    overrides: [
      /// регистрируем [KrsStorage]
      storageProvider.overrideWithValue(storage),

      /// регистрируем [DeviceDetails]
      deviceDetailsProvider.overrideWithValue(deviceDetails),
    ],
    child: const App(),
  ));
}
