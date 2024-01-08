import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../resources/krs_theme.dart';

class KrsAppBar extends HookWidget implements PreferredSizeWidget {
  final List<Widget> children;
  const KrsAppBar({
    super.key,
    this.children = const [],
  });

  @override
  Widget build(context) {
    return SizedBox.fromSize(
        size: preferredSize,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
          child: Row(
            children: [
              if (kDebugMode) const BackButton(),
              ...children,
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
