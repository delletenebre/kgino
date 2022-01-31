import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgino/ui/buttons/rounded_button.dart';

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
    // final theme = Theme.of(context);

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

          RoundedButton(
            onPressed: () {
              onRetry?.call();
            },
            child: const Text('Попробовать ещё раз'),
          ),

          const SizedBox(height: 32.0),

          RoundedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Назад'),
          ),

        ],
      ),
    );
  }
}