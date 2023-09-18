import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/krs_locale.dart';

class TryAgainMessage extends StatelessWidget {
  final String? imageUrl;
  final Function() onRetry;

  const TryAgainMessage({
    super.key,
    this.imageUrl,
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
          Container(
            clipBehavior: Clip.antiAlias,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: imageUrl == null
                  ? Icon(
                      Icons.live_tv_outlined,
                      color: theme.colorScheme.outline.withOpacity(0.36),
                    )
                  : Image.network(
                      imageUrl!,
                      alignment: Alignment.center,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              locale.errorLoadingVideo,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.tonal(
                  autofocus: true,
                  onPressed: () {
                    onRetry();
                  },
                  child: Text(locale.tryAgain),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                FilledButton.tonal(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(locale.back),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
