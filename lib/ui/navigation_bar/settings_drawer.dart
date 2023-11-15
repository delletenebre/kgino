import 'package:flutter/material.dart';

import '../../resources/constants.dart';
import '../../resources/krs_locale.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(context) {
    final locale = KrsLocale.of(context);
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: TvUi.hPadding + 8.0,
              top: TvUi.vPadding + 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(locale.settings),
                const Icon(Icons.settings),
              ],
            ),
          ),
          ListTile(
            autofocus: true,
            onTap: () {},
            title: Text('Аккаунт Filmix'),
          ),
          ListTile(
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
            },
            title: Text('Выйти из приложения'),
          ),
        ],
      ),
    );
  }
}
