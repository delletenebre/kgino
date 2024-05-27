import 'package:flutter/material.dart';

extension ThemeDataExtensions on BuildContext {
  Future<T?> showModal<T>({
    String titleText = '',
    required Widget child,
  }) {
    final theme = Theme.of(this);

    return showDialog<T>(
      context: this,
      barrierColor: Colors.black.withOpacity(0.62),
      barrierDismissible: true,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            width: 528.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
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

  Future<T?> showModalRight<T>({
    String titleText = '',
    required Widget child,
  }) {
    final theme = Theme.of(this);

    return showDialog<T>(
      context: this,
      barrierColor: theme.colorScheme.surface.withOpacity(0.96),
      barrierDismissible: true,
      builder: (context) => BackButtonListener(
        onBackButtonPressed: () async {
          return await Navigator.of(this).maybePop();
        },
        child: Scaffold(
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
      ),
    );
  }

  Future<T?> showStartModal<T>({
    String titleText = '',
    required Widget child,
  }) {
    final theme = Theme.of(this);

    return showGeneralDialog<T>(
      context: this,
      barrierColor: theme.colorScheme.surface.withOpacity(0.8),
      barrierLabel: 'dialog',
      barrierDismissible: true,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(20.0),
            width: 280.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (titleText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      titleText,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<T?> showEndModal<T>({
    String titleText = '',
    required Widget child,
  }) {
    final theme = Theme.of(this);

    return showGeneralDialog<T>(
      context: this,
      barrierColor: theme.colorScheme.surface.withOpacity(0.8),
      barrierLabel: 'dialog',
      barrierDismissible: true,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) => BackButtonListener(
        onBackButtonPressed: () async {
          return await Navigator.of(context).maybePop();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(20.0),
              width: 280.0,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (titleText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        titleText,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<T?> showConfirmModal<T>({
    String title = '',
    String message = '',
    required Widget child,
  }) {
    final theme = Theme.of(this);

    return showDialog<T>(
      context: this,
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
              color: theme.colorScheme.surfaceContainer,
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
                const SizedBox(width: 24.0),
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
