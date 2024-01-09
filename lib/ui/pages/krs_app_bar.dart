import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resources/krs_theme.dart';
import '../buttons/krs_back_button.dart';

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
    return Container(
      height: preferredSize.height,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TvUi.hPadding,
        ),
        child: Wrap(
          spacing: 24.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (kDebugMode) const KrsBackButton(),
            ...children,
          ],
        ),
      ),
    );
  }
}
