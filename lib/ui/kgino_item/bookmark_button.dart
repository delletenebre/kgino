import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../../models/kgino_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_storage.dart';

class BookmarkButton extends HookWidget {
  final KginoItem kginoItem;

  const BookmarkButton(this.kginoItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// хранилище данных
    final storage = GetIt.instance<KrsStorage>();

    /// сохранённый в базе данных элемент
    final dbItem = useStream(storage.db.kginoItems.watchObject(kginoItem.isarId),
      initialData: kginoItem,
    );

    if (dbItem.hasData && dbItem.data != null && dbItem.data!.bookmarked != null) {
      
      /// кнопка удаления из избранного
      return FilledButton.icon(
        onPressed: () async {
          
          /// убираем из избранного
          final item = dbItem.data!;
          item.bookmarked = null;
          await storage.db.writeTxn(() async {
            await storage.db.kginoItems.put(item);
          });

        },
        icon: const Icon(Icons.bookmark_remove),
        label: Text(locale.removeFromBookmarks),
      );

    } else {

      /// кнопка добавления в избранное
      return FilledButton.icon(
        onPressed: () async {

          /// добавляем в избранное
          final item = dbItem.data ?? kginoItem;
          item.bookmarked = DateTime.now();
          await storage.db.writeTxn(() async {
            await storage.db.kginoItems.put(item);
          });
          
        },
        icon: const Icon(Icons.bookmark_add_outlined),
        label: Text(locale.addToBookmarks),
      );

    }

  }
}