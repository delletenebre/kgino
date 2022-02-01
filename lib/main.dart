import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kgino/app.dart';
import 'package:kgino/models/favorite_model.dart';
import 'package:kgino/models/viewed_episode_model.dart';
import 'package:kgino/models/viewed_show_model.dart';

import 'controllers/controllers.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<FavoriteModel>(FavoriteModelAdapter());
  Hive.registerAdapter<ViewedShowModel>(ViewedShowModelAdapter());
  Hive.registerAdapter<ViewedEpisodeModel>(ViewedEpisodeModelAdapter());

  /// контроллер избранного
  await Hive.openBox<FavoriteModel>(FavoritesController.storageName);
  Get.put(FavoritesController());

  /// контроллер просмотренного
  await Hive.openBox<ViewedShowModel>(ViewedController.storageName);
  Get.put(ViewedController());

  runApp(const App());
}
