import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../../models/kgino_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_storage.dart';
import '../../resources/krs_theme.dart';

class BookmarkButton extends StatelessWidget {
  final KginoItem kginoItem;

  const BookmarkButton(this.kginoItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// хранилище данных
    final storage = GetIt.instance<KrsStorage>();

    // final dbItem = storage.db.kginoItems
    //   .filter()
    //   .isarIdEqualTo(kginoItem.isarId)
    //   .findFirst();

    // Stream<void> dbStream = storage.db.kginoItems.watchLazy();

    final dbItem = useStream(storage.db.kginoItems.watchObject(kginoItem.isarId),
      initialData: kginoItem,
    );

    return HookBuilder(
      builder: (context) {

        if (dbItem.hasData && dbItem.data != null) {
          
          /// кнопка удаления из избранного
          return FilledButton.icon(
            onPressed: () {
              /// убираем из избранного
              // seenItemsController.removeFavorite(show);
            },
            icon: const Icon(Icons.bookmark_remove),
            label: Text(locale.removeFromFavorites),
          );

        } else {

          /// кнопка добавления в избранное
          return FilledButton.icon(
            onPressed: () {
              /// добавляем в избранное
              // seenItemsController.addFavorite(show);
            },
            icon: const Icon(Icons.bookmark_add_outlined),
            label: Text(locale.addToFavorites),
          );

        }

        
      }
    );

    // return ValueListenableBuilder(
    //   valueListenable: seenItemsController.listenable,
    //   builder: (context, Box<MovieItem> box, _) {
    //     if (seenItemsController.hasFavorite(show)) {
    //       /// ^ если уже добавлен в избранное
          
    //       /// кнопка удаления из избранного
    //       return Padding(
    //         padding: const EdgeInsets.only(right: 8.0),
    //         child: ElevatedButton.icon(
    //           style: KrsTheme.filledTonalButtonStyleOf(context),
    //           onPressed: () {
    //             /// убираем из избранного
    //             seenItemsController.removeFavorite(show);
    //           },
    //           icon: const Icon(Icons.bookmark_remove),
    //           label: Text(locale.removeFromFavorites),
    //         ),
    //       );
          
    //     } else {
    //       /// ^ если ещё нет в избранном

    //       /// кнопка добавления в избранное
    //       return Padding(
    //         padding: const EdgeInsets.only(right: 8.0),
    //         child: ElevatedButton.icon(
    //           style: KrsTheme.filledTonalButtonStyleOf(context),
    //           onPressed: () {
    //             /// добавляем в избранное
    //             seenItemsController.addFavorite(show);
    //           },
    //           icon: const Icon(Icons.bookmark_add_outlined),
    //           label: Text(locale.addToFavorites),
    //         ),
    //       );
    //     }
    //   }
    // ),;
  }
}