
import 'package:flutter/material.dart';

class KrsBottomSheetContent extends StatelessWidget {
  final String titleText;
  final Widget child;

  const KrsBottomSheetContent({
    super.key,
    this.titleText = '',
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (titleText.isNotEmpty) Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(titleText,
              style: TextStyle(
                fontSize: 18.0,
                color: theme.colorScheme.onSecondaryContainer,
              )
            ),
          ),
          
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}