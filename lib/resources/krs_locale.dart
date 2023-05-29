import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class KrsLocale {
  KrsLocale._();

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  /// список поддерживаемых языков
  static final locales = {
    'ky': 'Кыргызча',
    'ru': 'Русский',
    'en': 'English',
  };

  /// язык по умолчанию
  static String get defaultLocale {
    return 'ru';
    // final systemLocale = Intl.systemLocale.substring(0, 2);

    // /// Проверяем есть ли в списке системный язык...
    // if (locales.containsKey(systemLocale)) {
    //   /// ...если есть - возвращаем системный
    //   return systemLocale;
    // } else {
    //   /// ...если нет - возвращаем первый из поддерживаемых
    //   return locales.keys.first;
    // }
  }

  //static String get currentLocale => Get.find<LocaleController>().locale;

  // static DateFormat get dateFormatter => DateFormat.yMMMMd(currentLocale);
  // static DateFormat get dateTimeFullFormatter => dateFormatter.add_Hms();
  // static DateFormat get dateTimeFormatter => dateFormatter.add_Hm();
}
