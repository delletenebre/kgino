import 'package:flutter/material.dart';
import 'package:kgino/app.dart';

import 'controllers/controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  /// контроллер избранного
  final favoritesController = FavoritesController();
  await favoritesController.storage.initStorage;
  Get.put(favoritesController);


  runApp(const App());
}
