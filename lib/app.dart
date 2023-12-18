import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/providers.dart';
import 'resources/krs_theme.dart';

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(context, ref) {
    /// контроллер маршрутов приложения
    final router = ref.watch(routerProvider);

    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp.router(
        routerConfig: router,
        theme: KrsTheme.dark,
        darkTheme: KrsTheme.dark,
        themeMode: ThemeMode.dark,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          },
        ),
      ),
    );
  }
}
