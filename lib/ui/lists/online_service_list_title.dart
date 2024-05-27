import 'package:flutter/material.dart';

import '../../models/category_list_item.dart';
import 'online_service_logo.dart';

class OnlineServiceListTitle extends StatelessWidget {
  final CategoryListItem category;

  const OnlineServiceListTitle(this.category, {super.key});

  @override
  Widget build(context) {
    final title = Text(
      category.title,
    );

    if (category.onlineService.logo.isEmpty) {
      return title;
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OnlineServiceLogo(category.onlineService.logo),
          const SizedBox(width: 12.0),
          title,
        ],
      );
    }
  }
}
