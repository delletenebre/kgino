import 'package:flutter/material.dart';

class Utils {
  static Future<T?> showModal<T>({
    required BuildContext context,
    String titleText = '',
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return showDialog<T>(
      context: context,
      barrierColor: theme.colorScheme.surface.withOpacity(0.96),
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          width: 360.0,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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

              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 480.0,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}