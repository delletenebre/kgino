import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/media_item.dart';
import '../../../providers/providers.dart';
import '../../../providers/locale_provider.dart';

class BookmarkButton extends HookConsumerWidget {
  final MediaItem mediaItem;

  const BookmarkButton(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(context, ref) {
    final locale = Locale.of(context);

    /// хранилище данных
    final storage = ref.read(storageProvider);

    final bookmarked = useState(
        storage.db?.mediaItems.get(mediaItem.dbId)?.bookmarked != null);

    // /// сохранённый в базе данных элемент
    // final mediaItemStream = useStream(
    //   storage.db.mediaItems.watchObject(mediaItem.dbId),
    //   initialData: mediaItem,
    // );

    // final dbItem = mediaItemStream.data!;

    if (bookmarked.value) {
      /// кнопка удаления из избранного
      return FilledButton.tonalIcon(
        onPressed: () {
          /// убираем из избранного
          mediaItem.bookmarked = null;
          mediaItem.save(storage);
          bookmarked.value = false;
        },
        icon: const Icon(Icons.bookmark_remove),
        label: Text(locale.removeFromBookmarks),
      );
    } else {
      /// кнопка добавления в избранное
      return FilledButton.tonalIcon(
        onPressed: () {
          /// добавляем в избранное
          mediaItem.bookmarked = DateTime.now();
          mediaItem.save(storage);
          bookmarked.value = true;
        },
        icon: const Icon(Icons.bookmark_add_outlined),
        label: Text(locale.addToBookmarks),
      );
    }
  }
}
