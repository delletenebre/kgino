import 'package:flutter/material.dart';

import '../../models/kgino_item.dart';
import 'krs_list_tile.dart';

class KginoListTile extends StatelessWidget {
  final FocusNode? focusNode;
  final KginoItem item;
  // final Size posterSize;
  final void Function(FocusNode focusNode)? onFocused;
  final void Function() onTap;

  const KginoListTile({
    super.key,
    this.focusNode,
    required this.item,
    // this.posterSize = const Size(126.0, 102.0),
    this.onFocused,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    return KrsListTile(
      focusNode: focusNode,
      onFocused: onFocused,
      // imageSize: posterSize,
      onTap: onTap,

      title: item.name,
      imageUrl: item.posterUrl,      
    );
  }
}
