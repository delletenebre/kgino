import 'package:flutter/material.dart';
import 'package:fvp/fvp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'models/device_details.dart';
import 'providers/providers.dart';
import 'resources/krs_storage.dart';

Future<void> main() async {
  // debugRepaintRainbowEnabled = true;
  // debugPaintLayerBordersEnabled = true;

  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  /// инициализируем видео-плеер
  registerWith(options: {
    'platforms': ['windows', 'macos', 'linux']
  });
  // MediaKit.ensureInitialized();

  await Supabase.initialize(
    url: 'https://app.iuk.edu.kg',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzA1ODYwMDAwLAogICJleHAiOiA5ODYzNzEyODAwCn0.GpraSLasJQKJutMZrx_6GBT2dt-mpWyflLYJGfUbM0E',
  );

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
