import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/ockg_api_provider.dart';
import 'api/tskg_api_provider.dart';
import 'app.dart';
import 'controllers/seen_items_controller.dart';
import 'controllers/tskg/tskg_favorites_controller.dart';
import 'models/seen_item.dart';
import 'resources/krs_storage.dart';

Future<void> main() async {
  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  /// инициализируем хранилище
  await Hive.initFlutter();

  /// регистрируем модель для просмотренных эпизодов
  Hive.registerAdapter(SeenItemAdapter());
  Hive.registerAdapter(SeenEpisodeAdapter());

  /// инициализируем хранилище
  await Hive.openBox<SeenItem>(SeenItemsController.storageKey);

  /// инициализируем локальное хранилище
  final sharedStorage = await SharedPreferences.getInstance();

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

  /// регистрируем контроллер просмотренных эпизодов как singleton
  GetIt.instance.registerSingleton<SeenItemsController>(
    SeenItemsController()
  );

  /// регистрируем контроллер избранных сериалов ts.kg как singleton
  GetIt.instance.registerSingleton<TskgFavoritesController>(
    TskgFavoritesController()
  );

  runApp(const App());
}
