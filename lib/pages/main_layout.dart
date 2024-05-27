import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/storage_provider.dart';
import '../ui/time/time_view.dart';

class MainLayout extends HookConsumerWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(context, ref) {
    useValueListenable(ref.watch(storageProvider).notifier);

    return Scaffold(
      body: Stack(
        children: [
          child,
          if (ref
              .read(storageProvider)
              .readBool('time_enabled', defaultValue: true))
            const Positioned(top: 12.0, right: 12.0, child: TimeView()),
        ],
      ),
    );
  }
}
