import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'api/flmx_api_provider.dart';
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

  
  /// регистрируем [KrsStorage] как singleton
  GetIt.instance.registerSingleton<KrsStorage>(
    await KrsStorage().initialize()
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

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<TskgApiProvider>(TskgApiProvider());

  /// регистрируем провайдер запросов веб-камер
  GetIt.instance.registerSingleton<WcamApiProvider>(WcamApiProvider());

  /// регистрируем контроллер для поискового запроса
  GetIt.instance.registerSingleton<TextEditingController>(TextEditingController());

  runApp(const App());
}
