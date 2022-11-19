import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/krs_locale.dart';

class EmptyItemMessage extends StatelessWidget {
  final Function() onRetry;

  const EmptyItemMessage({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_people,
            size: 128.0,
            color: theme.colorScheme.outline,
          ),

          const SizedBox(height: 24.0),

          OutlinedButton(
            autofocus: true,
            onPressed: () {
              onRetry();
            },
            child: Text(locale.tryAgain),
          ),

          // const SizedBox(height: 12.0),

          // OutlinedButton(
          //   onPressed: () {
          //     context.pop();
          //   },
          //   child: Text(locale.back),
          // ),

        ],
      ),
    );
  }
}