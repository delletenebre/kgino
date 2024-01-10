import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoviesPage extends HookConsumerWidget {
  const MoviesPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    return Placeholder(child: Text('фильмы'));
  }
}
