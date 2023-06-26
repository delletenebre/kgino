import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: appLogoWidth,
      child: TextButton(
        // canRequestFocus: false,
        // onTap: () {
        //   context.go('/');
        // },
        onPressed: () {
          context.go('/');
        },
        child: RichText(
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          text: TextSpan(
            text: 'KG',
            style: TextStyle(
              color: theme.colorScheme.outline,
              fontWeight: FontWeight.bold,
            ),

            children: const [
              TextSpan(
                text: 'ino',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),

              TextSpan(
                text: '    4.1.2',
                style: TextStyle(
                  fontSize: 6.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}