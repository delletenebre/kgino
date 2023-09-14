import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../extensions/riverpod_mixins.dart';
import '../resources/krs_locale.dart';
import 'providers.dart';

part 'app_theme.g.dart';

/// контроллер темы оформления
@riverpod
class AppTheme extends _$AppTheme with ValueMixins {
  /// ключ в хранилище
  static const _prefsKey = 'theme';

  @override
  ThemeMode build() {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// считываем значение с диска
    final themeMode = storage.read(_prefsKey);

    changeByString(themeMode);

    return state;
  }

  void changeTheme(ThemeMode themeMode) {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// сохраняем значение на диск
    storage.write(_prefsKey, themeMode.toString());

    state = themeMode;
  }

  void changeByString(String value) {
    switch (value) {
      case 'ThemeMode.light':
        return changeTheme(ThemeMode.light);
      case 'ThemeMode.dark':
        return changeTheme(ThemeMode.dark);
      case 'ThemeMode.system':
      default:
        return changeTheme(ThemeMode.system);
    }
  }

  String getName(BuildContext context) {
    final locale = KrsLocale.of(context);

    switch (state) {
      case ThemeMode.system:
        return locale.themeSystem;
      case ThemeMode.dark:
        return locale.themeDark;
      case ThemeMode.light:
        return locale.themeLight;
    }
  }

  String getNameFor(BuildContext context, ThemeMode themeMode) {
    final locale = KrsLocale.of(context);

    switch (themeMode) {
      case ThemeMode.system:
        return locale.themeSystem;
      case ThemeMode.dark:
        return locale.themeDark;
      case ThemeMode.light:
        return locale.themeLight;
    }
  }
}
