import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerError extends StatelessWidget {
  final String message;
  final Function()? onRetry;

  const PlayerError({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message,
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32.0),

          OutlinedButton.icon(
            onPressed: () {
              onRetry?.call();
            },
            icon: DecoratedIcon(Icons.refresh,
              color: theme.colorScheme.primary,
              shadows: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: theme.scaffoldBackgroundColor,
                ),
              ],
            ),
            label: const Text('Попробовать ещё раз'),
          ),

          const SizedBox(height: 16.0),

          OutlinedButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: DecoratedIcon(Icons.arrow_back,
              color: theme.colorScheme.primary,
              shadows: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: theme.scaffoldBackgroundColor,
                ),
              ],
            ),
            label: const Text('Назад'),
          ),

        ],
      ),
    );
  }
}