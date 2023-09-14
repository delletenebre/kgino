import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'app.dart';
import 'models/device_details.dart';
import 'providers/providers.dart';
import 'resources/krs_storage.dart';

Future<void> main() async {
  // debugRepaintRainbowEnabled = true;
  // debugPaintLayerBordersEnabled = true;

  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  /// информация об устройстве
  final deviceInfo = DeviceInfoPlugin();
  String deviceId = 'Unknown';
  String deviceModel = 'Unknown';
  String deviceBrand = 'Unknown';
  String deviceOsVersion = '0.0.0';
  if (kIsWeb) {
    final info = await deviceInfo.webBrowserInfo;
    deviceId = const Uuid().v4();
    deviceModel = info.product ?? 'Unknown';
    deviceBrand = info.vendor ?? 'Unknown';
    deviceOsVersion = info.appVersion ?? '0.0.0';
  } else if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    deviceId = info.id;
    deviceModel = info.model;
    deviceBrand = info.brand;
    deviceOsVersion = info.version.release;
  } else if (Platform.isWindows) {
    final info = await deviceInfo.windowsInfo;
    deviceId = info.deviceId;
    deviceModel = info.computerName;
    deviceBrand = info.registeredOwner;
    deviceOsVersion = '${info.productName} ${info.buildNumber}';
  }
  final deviceDetails = DeviceDetails(
    id: deviceId,
    name: deviceModel,
    vendor: deviceBrand,
    osVersion: deviceOsVersion,
  );

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
