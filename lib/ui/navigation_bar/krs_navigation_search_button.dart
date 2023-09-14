import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/providers.dart';
import '../../resources/krs_locale.dart';

class KrsNavigationSearchButton extends HookConsumerWidget {
  final String label;
  final IconData? icon;
  final void Function(bool hasFocus)? onFocusChange;
  final bool selected;

  const KrsNavigationSearchButton({
    super.key,
    this.label = '',
    this.icon,
    this.onFocusChange,
    this.selected = false,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    /// поисковой запрос
    final searchQuery = ref.watch(searchProvider);

    /// подписываемся на обновления поискового запроса
    useListenable(searchQuery);

    final focusNode = useFocusNode();

    final textFieldFocusNode = useFocusNode();

    final showExpanded = selected;

    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    final colorAnimation = useAnimation<Color?>(ColorTween(
            begin: theme.colorScheme.onSurface,
            end: theme.colorScheme.onInverseSurface)
        .animate(animationController));

    final backgroundColorAnimation = useAnimation<Color?>(ColorTween(
            begin: Colors.transparent, end: theme.colorScheme.inverseSurface)
        .animate(animationController));

    final searchBackgroundColorAnimation = useAnimation<Color?>(ColorTween(
      begin: theme.colorScheme.inverseSurface,
      end: Colors.transparent,
    ).animate(animationController));

    final foregroundColor = Color(colorAnimation!.value);
    final backgroundColor = Color(backgroundColorAnimation!.value);

    if (selected) {
      animationController.animateTo(1.0);
    } else {
      animationController.animateTo(0.0);
    }

    final searchField = Stack(
      alignment: Alignment.centerLeft,
      children: [
        TextField(
          focusNode: textFieldFocusNode,
          textInputAction: TextInputAction.search,
          controller: searchQuery,
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {},
          onSubmitted: (value) {
            focusNode.requestFocus();
          },
          style: TextStyle(
            fontSize: 14.0,
            height: 1.05,
            color: theme.colorScheme.onSurface,
            // fontWeight: FontWeight.w500,
          ),
          cursorHeight: 18.0,
          cursorOpacityAnimates: true,
          cursorColor: theme.colorScheme.primary,
          decoration: InputDecoration(
            constraints: const BoxConstraints(
              maxWidth: 268.0,
            ),
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 11.0,
              horizontal: 12.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
          ),
        ),
        //if (searchQuery.text.isEmpty)

        // AnimatedSwitcher(
        //   duration: kThemeAnimationDuration,
        //   transitionBuilder: (child, animation) {
        //     return WidthTransition(
        //       sizeFactor: animation,
        //       child: FadeTransition(
        //         opacity: animation,
        //         child: child,
        //       ),
        //     );
        //   },
        //   child:

        AnimatedPositioned(
          duration: kThemeAnimationDuration,
          top: selected && searchQuery.text.isEmpty ? 4.0 : 24.0,
          left: 12.0,
          child: AnimatedOpacity(
            duration: kThemeAnimationDuration,
            opacity: selected && searchQuery.text.isEmpty ? 1.0 : 0.0,
            child: IgnorePointer(
              child: Text(
                locale.searchHint,
                style: TextStyle(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    final textButton = Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 6.0),
            child: Icon(
              icon,
              size: 22.0,
              color: Color(colorAnimation.value),
            ),
          ),
        Text(
          label,
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
      ],
    );

    final child = AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      transitionBuilder: (child, animation) {
        return WidthTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: showExpanded ? searchField : textButton,
    );

    return Focus(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onKeyEvent: (node, event) {
        if ([LogicalKeyboardKey.enter, LogicalKeyboardKey.select]
            .contains(event.logicalKey)) {
          if (focusNode.hasFocus && !textFieldFocusNode.hasFocus) {
            textFieldFocusNode.requestFocus();
          }
        }

        return KeyEventResult.ignored;
      },
      child: Material(
        borderRadius: BorderRadius.circular(32.0),
        color: backgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(32.0),
          onTap: () {
            focusNode.requestFocus();
          },
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            padding: EdgeInsets.only(
              top: showExpanded ? 2.0 : 6.0,
              bottom: showExpanded ? 2.0 : 6.0,
              right: showExpanded ? 2.0 : 16.0,
              left: showExpanded
                  ? 2.0
                  : icon == null
                      ? 16.0
                      : 12.0,
            ),
            height: 32.0,
            child: child,
          ),
        ),
      ),
    );
  }
}

class WidthTransition extends AnimatedWidget {
  /// Creates a size transition.
  ///
  /// The [axis], [sizeFactor], and [axisAlignment] arguments must not be null.
  /// The [axis] argument defaults to [Axis.vertical]. The [axisAlignment]
  /// defaults to 0.0, which centers the child along the main axis during the
  /// transition.
  const WidthTransition({
    super.key,
    this.axis = Axis.vertical,
    required Animation<double> sizeFactor,
    this.child,
  }) : super(listenable: sizeFactor);

  /// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise
  /// [Axis.vertical].
  final Axis axis;

  Animation<double> get sizeFactor => listenable as Animation<double>;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(context) {
    return Align(
      alignment: Alignment.centerRight, //const AlignmentDirectional(1.0, -1.0),
      heightFactor: 1.0,
      widthFactor: max(sizeFactor.value, 0.0),
      child: child,
    );
  }
}
