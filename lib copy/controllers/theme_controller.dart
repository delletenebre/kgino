import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../resources/krs_storage.dart';

class ThemeController extends Cubit<ThemeMode> {
  /// ключ для сохранённого значения
  static const _prefsKey = 'theme';

  /// хранилище данных
  final _storage = GetIt.instance<KrsStorage>();

  ThemeController() : super(ThemeMode.system) {
    /// считываем значение с диска
    final themeMode = _storage.read(_prefsKey);

    switch (themeMode) {
      case 'ThemeMode.system':
        emit(ThemeMode.system);
        break;
      case 'ThemeMode.dark':
        emit(ThemeMode.dark);
        break;
      case 'ThemeMode.light':
        emit(ThemeMode.light);
        break;
    }
  }

  void changeTheme(ThemeMode themeMode) {
    emit(themeMode);
  }

  @override
  Future<void> onChange(Change<ThemeMode> change) async {
    super.onChange(change);

    /// сохраняем значение на диск
    _storage.write(_prefsKey, change.nextState.toString());
  }
}
