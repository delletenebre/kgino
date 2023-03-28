import 'package:flutter/material.dart';

import '../../models/kgino_item.dart';
import 'kgino_raw_list_tile.dart';

class KginoListTile extends StatelessWidget {
  final FocusNode focusNode;
  final KginoItem item;
  // final Size posterSize;
  final void Function(FocusNode focusNode)? onFocused;
  final void Function() onTap;

  const KginoListTile({
    super.key,
    required this.focusNode,
    required this.item,
    // this.posterSize = const Size(126.0, 102.0),
    this.onFocused,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    return KginoRawListTile(
      focusNode: focusNode,
      onFocused: onFocused,
      // imageSize: posterSize,
      onTap: onTap,

      title: item.name,
      subtitle: item.subtitle,
      imageUrl: item.posterUrl,      
    );
  }
}
