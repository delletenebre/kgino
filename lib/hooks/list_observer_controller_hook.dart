import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

/// Creates [ListObserverController] that will be disposed automatically.
///
/// See also:
/// - [ListObserverController]
ListObserverController useListObserverController({
  double initialScrollOffset = 0.0,
  bool keepScrollOffset = true,
  String? debugLabel,
  List<Object?>? keys,
}) {
  return use(
    _ListObserverControllerHook(
      initialScrollOffset: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      debugLabel: debugLabel,
      keys: keys,
    ),
  );
}

class _ListObserverControllerHook extends Hook<ListObserverController> {
  const _ListObserverControllerHook({
    required this.initialScrollOffset,
    required this.keepScrollOffset,
    this.debugLabel,
    super.keys,
  });

  final double initialScrollOffset;
  final bool keepScrollOffset;
  final String? debugLabel;

  @override
  HookState<ListObserverController, Hook<ListObserverController>>
      createState() => _ListObserverControllerHookState();
}

class _ListObserverControllerHookState
    extends HookState<ListObserverController, _ListObserverControllerHook> {
  late final controller = ListObserverController(
    controller: ScrollController(),
  );

  @override
  ListObserverController build(context) => controller;

  @override
  void dispose() {
    try {
      controller.controller?.dispose();
    } catch (exception) {
      // do nothing, already disposed or null
    }
  }

  @override
  String get debugLabel => 'useListObserverController';
}
