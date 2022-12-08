import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/ockg_api_provider.dart';
import 'api/tskg_api_provider.dart';
import 'app.dart';
import 'controllers/seen_items_controller.dart';
import 'controllers/tskg/tskg_favorites_controller.dart';
import 'models/episode_item.dart';
import 'models/movie_item.dart';
import 'models/seen_item.dart';
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
  //await Hive.openBox<MovieItem>('items');


  // final ts = TskgMovieItem(
  //   //type: MovieItemType.tskg,
  //   id: '123',
  //   name: '1323',
  //   // posterUrl: '',
  //   // updatedAt: DateTime.now(),
  // );
  // Hive.box<MovieItem>('items').add(
  //   ts,
  // );

  // print(Hive.box<MovieItem>('items').values);
  // print('after');


  /// регистрируем модель для просмотренных эпизодов
  // Hive.registerAdapter(SeenItemAdapter());
  // Hive.registerAdapter(SeenEpisodeAdapter());

  /// инициализируем хранилище
  //await Hive.openBox<MovieItem>(SeenItemsController.storageKey);

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
