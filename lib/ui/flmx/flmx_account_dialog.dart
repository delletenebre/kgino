import 'package:flutter/material.dart';

import '../../resources/krs_locale.dart';

class FlmxAccountDialog extends StatelessWidget {
  const FlmxAccountDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);
    
    return ListView(
      shrinkWrap: true,
      children: [

        const Text('Перейдите на страницу filmix.ac/console и введите код:',
          textAlign: TextAlign.center,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
          ),
          child: Text('4lfd'.toUpperCase(),
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const Text('после добавления устройства на сайте, нажмите кнопку "Активировать"',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12.0),

        FilledButton.tonal(
          autofocus: true,
          onPressed: () {
            Navigator.of(context).pop();

          },
          child: const Text('Активировать'),
        ),

        const SizedBox(height: 4.0),

        FilledButton.tonal(
          onPressed: () {
            Navigator.of(context).pop();

          },
          child: Text(locale.cancel),
        ),
      ],
    );
  }
}