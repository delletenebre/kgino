import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/krs_locale.dart';

class TryAgainMessage extends StatelessWidget {
  final String? poster;
  final Function() onRetry;

  const TryAgainMessage({
    super.key,
    this.poster,
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
            padding: const EdgeInsets.only(bottom: 48.0),
            width: 256.0,
            height: 256.0,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: poster == null
                  ? Icon(
                      Icons.live_tv_outlined,
                      color: theme.colorScheme.outline.withOpacity(0.36),
                    )
                  : Image.network(
                      poster!,
                      alignment: Alignment.center,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(locale.errorLoadingVideo),
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
