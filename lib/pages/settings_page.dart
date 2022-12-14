import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box('settings');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
          valueListenable: settingsBox.listenable(keys: ['animations']),
          builder: (context, box, child) {
            return ListTile(
              title: child,
              trailing: Switch(
                value: box.get('animations', defaultValue: false),
                onChanged: (bool changed) {
                  box.put('animations', changed);
                },
              ),
            );
          },
          child: Text('Анимации'),
        ),
      ]
    );
  }
}
