import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/krs_locale.dart';


class LocaleController extends GetxController {
  /// хранилище
  late final SharedPreferences _storage;

  /// ключ в хранилище для сохранённого значения
  static const _storageKey = 'locale';

  /// текущий язык приложения
  final _locale = KrsLocale.defaultLocale.obs;
  String get locale => _locale.value;
  set locale(String value) => _locale.value = value;

  @override
  onInit() async {
    /// инициализируем хранилище
    _storage = await SharedPreferences.getInstance();

    /// считываем последние сохранённые значения с диска
    locale = _storage.getString(_storageKey) ?? KrsLocale.defaultLocale;

    /// при изменении параметров - записываем значения на диск
    ever(_locale, (String value) async {
      await _storage.setString(_storageKey, value);
    });

    super.onInit();
  }
}
