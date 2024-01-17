import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/krs_theme.dart';
import '../buttons/krs_back_button.dart';

class KrsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => TvUi.navigationBarSize;

  final List<Widget> children;
  final double spacing;

  const KrsAppBar({
    super.key,
    this.children = const [],
    this.spacing = 24.0,
  });

  @override
  Widget build(context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TvUi.hPadding,
          ),
          child: Wrap(
            spacing: spacing,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (kDebugMode && context.canPop()) const KrsBackButton(),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
