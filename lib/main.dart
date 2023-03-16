import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kgino/controllers/tabs_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
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

  /// регистрируем [TabsCubit] как singleton
  GetIt.instance.registerSingleton<TabsCubit>(
    TabsCubit(1)
  );

  /// регистрируем провайдер запросов к REST API как singleton
  // GetIt.instance.registerSingleton<ApiProvider>(
  //   ApiProvider()
  // );

  runApp(const App());
}
