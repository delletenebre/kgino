import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/ockg_api_provider.dart';
import 'api/tskg_api_provider.dart';
import 'api/wcam_api_provider.dart';
import 'app.dart';
import 'controllers/seen_items_controller.dart';
import 'firebase_options.dart';
import 'models/episode_item.dart';
import 'models/movie_item.dart';
import 'resources/krs_storage.dart';

Future<void> main() async {
  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  /// инициализируем хранилище
  await Hive.initFlutter();

  /// регистрируем модели для просмотренных эпизодов
  Hive.registerAdapter(MovieItemTypeAdapter());
  Hive.registerAdapter(MovieItemAdapter());
  Hive.registerAdapter(EpisodeItemAdapter());

  /// инициализируем хранилище
  await Hive.openBox<MovieItem>(SeenItemsController.storageKey);

  /// инициализируем локальное хранилище
  final sharedStorage = await SharedPreferences.getInstance();

  /// инициализируем firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// настраиваем crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  
  /// pass all uncaught asynchronous errors that aren't handled by the Flutter
  /// framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  /// регистрируем [KrsStorage] как singleton
  GetIt.instance.registerSingleton<KrsStorage>(
    KrsStorage(
      sharedStorage: sharedStorage,
      // secureStorage: secureStorage,
    )
  );

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<OckgApiProvider>(
    OckgApiProvider()
  );

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<TskgApiProvider>(
    TskgApiProvider()
  );

  /// регистрируем провайдер запросов к REST API как singleton
  GetIt.instance.registerSingleton<WcamApiProvider>(
    WcamApiProvider()
  );

  /// регистрируем контроллер просмотренных эпизодов как singleton
  GetIt.instance.registerSingleton<SeenItemsController>(
    SeenItemsController()
  );

  runApp(const App());
}
