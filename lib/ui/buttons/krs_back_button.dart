import 'package:flutter/material.dart';

class KrsBackButton extends StatelessWidget {
  const KrsBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.chevron_left_outlined),
      label: Text('Назад'),
    );
  }
}
