import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgino/ui/shadowed_icon.dart';

class SearchShowButton extends StatelessWidget {
  const SearchShowButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: OutlinedButton.icon(
        onPressed: () {
          Get.toNamed('/tskg/search');
        },

        icon: const ShadowedIcon(Icons.search),

        label: const Text('Поиск сериала'),
      ),
    );
  }
}