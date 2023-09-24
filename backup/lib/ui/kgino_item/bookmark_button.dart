import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/kgino_item.dart';
import '../../resources/krs_locale.dart';

class BookmarkButton extends HookWidget {
  final KginoItem kginoItem;

  const BookmarkButton(
    this.kginoItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    /// сохранённый в базе данных элемент
    final kginoItemStream = useStream(
      kginoItem.dbStream,
      initialData: kginoItem,
    );

    final dbItem = kginoItemStream.data!;

    if (dbItem.bookmarked != null) {
      /// кнопка удаления из избранного
      return FilledButton.tonalIcon(
        onPressed: () async {
          /// убираем из избранного
          kginoItem.bookmarked = null;
          await kginoItem.save();
        },
        icon: const Icon(Icons.bookmark_remove),
        label: Text(locale.removeFromBookmarks),
      );
    } else {
      /// кнопка добавления в избранное
      return FilledButton.tonalIcon(
        onPressed: () async {
          /// добавляем в избранное
          kginoItem.bookmarked = DateTime.now();
          await kginoItem.save();
        },
        icon: const Icon(Icons.bookmark_add_outlined),
        label: Text(locale.addToBookmarks),
      );
    }
  }
}
