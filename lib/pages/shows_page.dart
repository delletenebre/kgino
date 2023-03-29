import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/kgino_raw_list_tile.dart';
import '../ui/lists/vertical_list_view.dart';

class ShowsPage extends HookWidget {
  const ShowsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VerticalListView(
      itemCount: 1,
      itemBuilder: (context, focusNode, index) {
        return HorizontalListView(
          focusNode: focusNode,
          titleText: 'Выберите сервис',
          itemsFuture: Future.delayed(Duration.zero, () {
            return [
              /// ссылка на filmix
              {
                'name': 'Filmix',
                // 'imageUrl': 'https://filmix.ac/templates/Filmix/media/img/svg/logo.svg',
                'imageUrl': 'assets/images/flmx.svg',
                'route': '/flmx/shows',
              },

              /// ссылка на ts.kg
              {
                'name': 'TS.KG',
                // 'imageUrl': 'https://www.ts.kg/img/logo.svg',
                'imageUrl': 'assets/images/tskg.svg',
                'route': '/tskg',
              },

            ];
          }),
          itemBuilder: (context, focusNode, index, item) {
            return KginoRawListTile(
              focusNode: focusNode,
              onFocused: (focusNode) {
                
              },
              onTap: () {
                context.go(item['route']!);
              },
              title: item['name']!,
              imageUrl: item['imageUrl']!,
            );
          },
          
        );
      },
    );
  }
}