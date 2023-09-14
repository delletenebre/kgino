import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../resources/krs_locale.dart';
import 'providers.dart';

part 'app_locale.g.dart';

@riverpod
/// контроллер языка приложения
class AppLocale extends _$AppLocale {

  /// ключ в хранилище
  static const _prefsKey = 'locale';

  @override
  String build() {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// считываем значение с диска
    final locale = storage.read(_prefsKey,
      defaultValue: KrsLocale.defaultLocale,
    );

    return locale;
  }

  Future<void> changeLocale(String locale) async {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// обновляем локализацию для формата дат и прочего
    Intl.defaultLocale = locale;

    /// сохраняем значение на диск
    storage.write(_prefsKey, locale);

    state = locale;
  }

}