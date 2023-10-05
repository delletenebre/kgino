import 'package:flutter/material.dart';

import 'resources/krs_theme.dart';

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
      barrierDismissible: true,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            width: 528.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (titleText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      titleText,
                      style: theme.textTheme.headlineMedium,
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
      ),
    );
  }

  static Future<T?> showModalRight<T>({
    required BuildContext context,
    String titleText = '',
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return showDialog<T>(
      context: context,
      barrierColor: theme.colorScheme.surface.withOpacity(0.96),
      barrierDismissible: true,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(24.0),
            width: 280.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (titleText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      titleText,
                      style: theme.textTheme.titleLarge,
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
      ),
    );
  }

  static Future<T?> showConfirmModal<T>({
    required BuildContext context,
    String title = '',
    String message = '',
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return showDialog<T>(
      context: context,
      barrierColor: theme.colorScheme.surface.withOpacity(0.96),
      barrierDismissible: true,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 34.0,
              vertical: 50.0,
            ),
            margin: const EdgeInsets.all(24.0),
            height: 200.0,
            decoration: BoxDecoration(
              color: KrsTheme.getSurfaceContainer(context),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        message,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 268.0,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
