import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

R useListenableSelectorCondition<R>({
  required Listenable listenable,
  required R Function() selector,
  required bool Function(R oldValue, R newValue) condition,
}) {
  return use(_ListenableSelectorHook(listenable, selector, condition));
}

class _ListenableSelectorHook<R> extends Hook<R> {
  const _ListenableSelectorHook(this.listenable, this.selector, this.condition);

  final Listenable listenable;
  final R Function() selector;
  final bool Function(R oldValue, R newValue) condition;

  @override
  _ListenableSelectorHookState<R> createState() =>
      _ListenableSelectorHookState<R>();
}

class _ListenableSelectorHookState<R>
    extends HookState<R, _ListenableSelectorHook<R>> {
  late R _selectorResult = hook.selector();

  @override
  void initHook() {
    super.initHook();
    hook.listenable.addListener(_listener);
  }

  @override
  void didUpdateHook(_ListenableSelectorHook<R> oldHook) {
    super.didUpdateHook(oldHook);

    if (hook.selector != oldHook.selector) {
      setState(() {
        _selectorResult = hook.selector();
      });
    }

    if (hook.listenable != oldHook.listenable) {
      oldHook.listenable.removeListener(_listener);
      hook.listenable.addListener(_listener);
      _selectorResult = hook.selector();
    }
  }

  @override
  R build(BuildContext context) => _selectorResult;

  void _listener() {
    final latestSelectorResult = hook.selector();
    if (hook.condition(latestSelectorResult, _selectorResult)) {
      setState(() {
        _selectorResult = latestSelectorResult;
      });
    }
  }

  @override
  void dispose() {
    hook.listenable.removeListener(_listener);
  }

  @override
  String get debugLabel => 'useListenableSelectorCondition<$R>';

  @override
  bool get debugSkipValue => true;
}
