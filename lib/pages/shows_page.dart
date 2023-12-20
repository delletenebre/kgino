import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../models/media_item.dart';
import '../resources/krs_theme.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class ShowsPage extends HookWidget {
  const ShowsPage({super.key});

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    final selectedMediaItem = useState<int?>(null);

    final a = MediaItem.tskg('1', 'tit1');
    print(a.dbId);

    final b = MediaItem.tskg('2', 'tit2');
    print(b.dbId);

    final c = MediaItem.filmix('3', 'tit2');
    print(c.dbId);

    return Column(
      children: [
        AnimatedContainer(
          duration: kThemeAnimationDuration,
          height: selectedMediaItem.value == null ? 0.0 : 316.0,
          child: SizedBox(),
        ),
        Expanded(
          child: VerticalListView(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            onFocusChanged: (hasFocus) {
              if (!hasFocus) {
                selectedMediaItem.value = null;
              }
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      KrsTheme.safeArea.horizontal,
                      0.0,
                      KrsTheme.safeArea.horizontal,
                      24.0,
                    ),
                    child: Text(
                      'Последние поступления',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: MediaItemCard.height,
                    child: HorizontalListView(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return MediaItemCard(
                          child: Text('index $index'),
                          onFocusChanged: (hasFocus) {
                            if (hasFocus) {
                              selectedMediaItem.value = index;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
