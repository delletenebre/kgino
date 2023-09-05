import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fvp/fvp.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import 'api/flmx_api_provider.dart';
import 'api/hdrz_api_provider.dart';
import 'api/ockg_api_provider.dart';
import 'api/tskg_api_provider.dart';
import 'api/wcam_api_provider.dart';
import 'app.dart';
import 'controllers/tabs_cubit.dart';
import 'models/device_details.dart';
import 'resources/krs_storage.dart';

Future<void> main() async {
  // debugRepaintRainbowEnabled = true;
  // debugPaintLayerBordersEnabled = true;

  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  // if (!kIsWeb && Platform.isWindows) {
  //   WindowsVideoPlayer.registerWith();
  // }
  registerWith();

  /// регистрируем [KrsStorage] как singleton
  GetIt.instance.registerSingleton<KrsStorage>(await KrsStorage().initialize());

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

  GetIt.instance.registerSingleton<DeviceDetails>(DeviceDetails(
    id: deviceId,
    name: deviceModel,
    vendor: deviceBrand,
    osVersion: deviceOsVersion,
  ));

  /// регистрируем [TabsCubit] как singleton
  GetIt.instance.registerSingleton<TabsCubit>(TabsCubit(1));

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<FlmxApiProvider>(FlmxApiProvider());

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<OckgApiProvider>(OckgApiProvider());

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<TskgApiProvider>(TskgApiProvider());

  /// регистрируем провайдер запросов веб-камер
  GetIt.instance.registerSingleton<WcamApiProvider>(WcamApiProvider());

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<HdrzApiProvider>(HdrzApiProvider());

  /// регистрируем контроллер для поискового запроса
  GetIt.instance
      .registerSingleton<TextEditingController>(TextEditingController());

  runApp(const App());
}
