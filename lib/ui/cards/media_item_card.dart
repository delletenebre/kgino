import 'package:flutter/material.dart';

import '../../models/media_item.dart';
import 'item_card.dart';

class MediaItemCard extends StatelessWidget {
  final MediaItem mediaItem;
  final void Function(bool hasFocus)? onFocusChange;
  final void Function() onPressed;

  const MediaItemCard({
    super.key,
    required this.mediaItem,
    this.onFocusChange,
    required this.onPressed,
  });

  @override
  Widget build(context) {
    return ItemCard(
      title: mediaItem.title,
      imageUrl: mediaItem.poster,
      onFocusChange: onFocusChange,
      onPressed: () {
        onPressed.call();
        return KeyEventResult.handled;
      },
    );
  }
}
