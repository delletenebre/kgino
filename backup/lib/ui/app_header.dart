import 'package:flutter/material.dart';

import 'app_logo.dart';

class AppHeader extends StatelessWidget {
  final Widget child;

  const AppHeader({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        height: 48.0,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 32.0),
              child: AppLogo(),
            ),

            DefaultTextStyle(
              style: DefaultTextStyle.of(context).style.copyWith(
                fontSize: 24.0,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}