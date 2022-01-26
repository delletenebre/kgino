import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AppLocale {
  AppLocale._();

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  /// Список поддерживаемых языков
  static final locales = {
    'ru': 'Русский',
    'ky': 'Кыргызча',
    'en': 'English',
  };

  /// Язык по умолчанию
  static String get defaultLocale {
    final systemLocale = Intl.systemLocale.substring(0, 2);

    /// Проверяем есть ли в списке системный язык...
    if (locales.containsKey(systemLocale)) {
      /// ...если есть - возвращаем системный
      return systemLocale;
    } else {
      /// ...если нет - возвращаем первый из поддерживаемых
      return locales.keys.first;
    }
  }

  // static String get currentLocale => Get.find<LocaleController>().locale.val;

  // static DateFormat get dateFormatter => DateFormat.yMMMMd(currentLocale);
  // static DateFormat get dateTimeFullFormatter => dateFormatter.add_Hms();
  // static DateFormat get dateTimeFormatter => dateFormatter.add_Hm();

  static final dateFormatter = DateFormat.yMMMd();
}