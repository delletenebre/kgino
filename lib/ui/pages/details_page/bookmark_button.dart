import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/media_item.dart';
import '../../../providers/providers.dart';
import '../../../resources/krs_locale.dart';

class BookmarkButton extends HookConsumerWidget {
  final MediaItem mediaItem;

  const BookmarkButton(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(context, ref) {
    final locale = KrsLocale.of(context);

    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// сохранённый в базе данных элемент
    final mediaItemStream = useStream(
      storage.db.mediaItems.watchObject(mediaItem.isarId),
      initialData: mediaItem,
    );

    final dbItem = mediaItemStream.data!;

    if (dbItem.bookmarked != null) {
      /// кнопка удаления из избранного
      return FilledButton.tonalIcon(
        onPressed: () async {
          /// убираем из избранного
          mediaItem.bookmarked = null;
          mediaItem.save(storage);
        },
        icon: const Icon(Icons.bookmark_remove),
        label: Text(locale.removeFromBookmarks),
      );
    } else {
      /// кнопка добавления в избранное
      return FilledButton.tonalIcon(
        onPressed: () async {
          /// добавляем в избранное
          mediaItem.bookmarked = DateTime.now();
          mediaItem.save(storage);
        },
        icon: const Icon(Icons.bookmark_add_outlined),
        label: Text(locale.addToBookmarks),
      );
    }
  }
}
