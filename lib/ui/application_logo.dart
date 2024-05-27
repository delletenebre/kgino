import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/device_provider.dart';

class ApplicationLogo extends ConsumerWidget {
  const ApplicationLogo({super.key});

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);

    final device = ref.read(deviceProvider);

    return DefaultTextStyle(
      softWrap: false,
      style: theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.0,
        color: theme.colorScheme.outline,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisAlignment: MainAxisAlignment.start,
        textBaseline: TextBaseline.alphabetic,
        children: [
          const SizedBox(width: 4.0),
          Text(
            'KG',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 0.5),
          Text(
            'ino',
            style: TextStyle(),
          ),
          const SizedBox(width: 8.0),
          Text(
            device.applicationVersion,
            style: TextStyle(
              fontSize: 8.0,
            ),
          ),
        ],
      ),
    );
  }
}
