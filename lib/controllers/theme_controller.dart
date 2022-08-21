import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  /// хранилище
  late final SharedPreferences _storage;
  
  /// ключ в хранилище для сохранённого значения
  static const _storageKey = 'darkModeEnabled';

  /// текущая тема оформления
  final Rx<bool?> _darkModeEnabled = null.obs;
  bool? get darkModeEnabled => _darkModeEnabled.value;
  set darkModeEnabled(bool? value) => _darkModeEnabled.value = value;

  /// текущая тема оформления
  // final _themeMode = ThemeMode.system.obs;
  // ThemeMode get themeMode => _themeMode.value;
  // set themeMode(ThemeMode value) => _themeMode.value = value;

  ThemeMode get themeMode {
    return ThemeMode.dark;
    if (darkModeEnabled == null) {
      return ThemeMode.system;
    } else if (darkModeEnabled == true) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  @override
  void onInit() async {
    /// инициализируем хранилище
    _storage = await SharedPreferences.getInstance();

    /// считываем тему оформления
    darkModeEnabled = _storage.getBool(_storageKey);

    /// при изменении параметров - записываем значения на диск
    ever(_darkModeEnabled, (bool? value) {
      if (value == null) {
        _storage.remove(_storageKey);
      } else {
        _storage.setBool(_storageKey, value);
      }
    });

    super.onInit();
  }
}