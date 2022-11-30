import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../resources/krs_locale.dart';
import '../../resources/krs_storage.dart';

class LocaleController extends Cubit<String> {
  /// ключ для сохранённого значения
  static const _prefsKey = 'tskg_favorites';

  /// хранилище данных
  final _storage = GetIt.instance<KrsStorage>();

  LocaleController() : super(KrsLocale.defaultLocale) {
    /// считываем значение с диска
    

    // Hive.openBox<TskgFavorites>(_prefsKey).then((box) {

    // });
    
    final favorites = _storage.read(_prefsKey,
      defaultValue: '[]'
    );

    //emit(locale);
    emit('ru');
  }

  void changeLocale(String locale) {
    emit(locale);
  }

  @override
  Future<void> onChange(Change<String> change) async {
    super.onChange(change);

    /// сохраняем значение на диск
    _storage.write(_prefsKey, change.nextState);
  }
}
