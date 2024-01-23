import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/krs_theme.dart';
import '../buttons/krs_back_button.dart';

class KrsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => TvUi.navigationBarSize;

  final List<Widget> children;

  final List<Widget> wrapChildren;
  final double spacing;

  final bool backButtonEnabled;

  const KrsAppBar({
    super.key,
    this.children = const [],
    this.wrapChildren = const [],
    this.spacing = 24.0,
    this.backButtonEnabled = true,
  });

  @override
  Widget build(context) {
    Widget? wrapped;
    if (wrapChildren.isNotEmpty) {
      wrapped = Expanded(
        child: Wrap(
          spacing: spacing,
          children: wrapChildren,
        ),
      );
    }

    return SafeArea(
      child: Container(
        height: preferredSize.height,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TvUi.hPadding,
          ),
          child: Row(
            children: [
              if ((kDebugMode || kIsWeb) &&
                  context.canPop() &&
                  backButtonEnabled)
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: KrsBackButton(),
                ),
              ...children,
              if (wrapped != null) wrapped,
            ],
          ),
        ),
      ),
    );
  }
}
