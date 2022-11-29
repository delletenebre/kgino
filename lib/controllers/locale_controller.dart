import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../resources/krs_locale.dart';
import '../resources/krs_storage.dart';

class LocaleController extends Cubit<String> {
  /// ключ для сохранённого значения
  static const _prefsKey = 'locale';

  /// хранилище данных
  final _storage = GetIt.instance<KrsStorage>();


  LocaleController() : super(KrsLocale.defaultLocale) {
    /// считываем значение с диска
    final locale = _storage.read(_prefsKey,
      defaultValue: KrsLocale.defaultLocale
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
