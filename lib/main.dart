import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api/api_provider.dart';
import 'app.dart';
import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';

void main() {
  /// инициализируем движок взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  /// контроллер языка приложения
  Get.put(LocaleController(), permanent: true);
  /// контроллер темы оформления приложения
  Get.put(ThemeController(), permanent: true);
  // /// контроллер авторизации
  // Get.put(AuthController(), permanent: true);
  /// контроллер запросов к API-серверу
  Get.put(ApiProvider(), permanent: true);


  runApp(App());
}
