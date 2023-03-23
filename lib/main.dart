import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/flmx_api_provider.dart';
import 'api/ockg_api_provider.dart';
import 'app.dart';
import 'controllers/tabs_cubit.dart';
import 'models/device_details.dart';
import 'resources/krs_storage.dart';

Future<void> main() async {
  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  /// инициализируем локальное хранилище
  final sharedStorage = await SharedPreferences.getInstance();

  /// регистрируем [KrsStorage] как singleton
  GetIt.instance.registerSingleton<KrsStorage>(
    KrsStorage(
      sharedStorage: sharedStorage,
    )
  );


  /// информация об устройстве
  final deviceInfo = DeviceInfoPlugin();
  final androidDeviceInfo = await deviceInfo.androidInfo;
  GetIt.instance.registerSingleton<DeviceDetails>(
    DeviceDetails(
      id: androidDeviceInfo.id,
      name: androidDeviceInfo.model,
      vendor: androidDeviceInfo.brand,
      osVersion: androidDeviceInfo.version.release,
    )
  );


  /// регистрируем [TabsCubit] как singleton
  GetIt.instance.registerSingleton<TabsCubit>(
    TabsCubit(1)
  );

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<FlmxApiProvider>(FlmxApiProvider());

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<OckgApiProvider>(OckgApiProvider());

  runApp(const App());
}
