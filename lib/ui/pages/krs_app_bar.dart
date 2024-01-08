import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resources/krs_theme.dart';

class KrsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => TvUi.navigationBarSize;

  final List<Widget> children;

  const KrsAppBar({
    super.key,
    this.children = const [],
  });

  @override
  Widget build(context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: Row(
        children: [
          if (kDebugMode) BackButton(),
          ...children,
        ],
      ),
    );
  }
}
