import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../resources/krs_locale.dart';
import '../../../resources/krs_theme.dart';
import '../../controllers/tabs_cubit.dart';

class KrsTabBarSearchButton extends HookWidget {
  final int index;
  final VoidCallback? onPressed;

  const KrsTabBarSearchButton({
    super.key,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final textFieldFocusNode = useFocusNode();

    final tabsCubit = ref.watch(tabsProvider);

    /// контроллер поискового запроса
    final textEditingController = ref.watch(searchProvider);

    final focusState = useState(false);

    final selected = tabsCubit.state == index;
    final focusNode = tabsCubit.focusNodes[index];
    void onFocusChange(hasFocus) {
      if (hasFocus) {
        tabsCubit.updateSelected(index);
      }

      focusState.value = hasFocus;
    }

    Color? backgroundColor;
    if (focusState.value) {
      backgroundColor = theme.colorScheme.primary.withOpacity(0.24);
    } else if (selected) {
      backgroundColor = theme.colorScheme.primary.withOpacity(0.12);
    }
    final foregroundColor = theme.textTheme.bodyMedium?.color;

    final buttonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );

    return TextButton.icon(
      clipBehavior: Clip.antiAlias,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      style: buttonStyle,
      onPressed: () {
        //tabsCubit.unfocusAll();
        tabsCubit.updateSelected(index);

        Future.delayed(KrsTheme.animationDuration, () {
          textFieldFocusNode.requestFocus();
        });
      },
      icon: const Icon(Icons.search_rounded),
      label: AnimatedSwitcher(
        duration: KrsTheme.animationDuration,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: WidthTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        },
        child: !selected
            ? Text(locale.search)
            : TextField(
                focusNode: textFieldFocusNode,
                textInputAction: TextInputAction.search,
                controller: textEditingController,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {},
                onSubmitted: (value) {
                  focusNode.requestFocus();
                },
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.0,
                  // fontWeight: FontWeight.w500,
                ),
                cursorHeight: 20.0,
                cursorOpacityAnimates: true,
                decoration: InputDecoration(
                  constraints: const BoxConstraints(
                    maxWidth: 200.0,
                    // minWidth: 200.0,
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.only(top: 0.0),

                  hintText: locale.searchHint,
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    height: 1.0,
                    color: theme.colorScheme.outline,
                    // fontWeight: FontWeight.w500,
                  ),

                  // border: OutlineInputBorder(),
                  border: InputBorder.none,
                ),
              ),
      ),
      // label: AnimatedContainer(
      //   duration: KrsTheme.animationDuration,
      //   width: selected ? 200.0 : locale.search.characters.length * 9.0,
      //   child: TextField(
      //     enabled: selected,
      //     focusNode: textFieldFocusNode,
      //     textInputAction: TextInputAction.search,
      //     controller: textEditingController,
      //     textAlignVertical: TextAlignVertical.center,

      //     onChanged: (value) {
      //     },

      //     onSubmitted: (value) {
      //       focusNode.requestFocus();
      //     },

      //     style: const TextStyle(
      //       fontSize: 14.0,
      //       height: 1.0,
      //       // fontWeight: FontWeight.w500,
      //     ),
      //     cursorHeight: 20.0,
      //     cursorOpacityAnimates: true,

      //     decoration: InputDecoration(
      //       isCollapsed: true,
      //       contentPadding: const EdgeInsets.only(top: 0.0),

      //       hintText: selected ? locale.searchHint : locale.search,
      //       hintStyle: TextStyle(
      //         fontSize: 14.0,
      //         height: 1.0,
      //         color: selected ? theme.colorScheme.outline : theme.textTheme.bodyMedium?.color,
      //         // fontWeight: FontWeight.w500,
      //       ),

      //       // border: OutlineInputBorder(),
      //       border: InputBorder.none,
      //     ),
      //   ),
      // ),
      // AnimatedSwitcher(
      //   duration: KrsTheme.animationDuration,
      //   transitionBuilder: (child, animation) {
      //     return FadeTransition(
      //       opacity: animation,
      //       child: SizeTransition(
      //         sizeFactor: animation,
      //         axis: Axis.horizontal,
      //         axisAlignment: 1.0,
      //         child: child,
      //       ),
      //     );
      //   },
      //   child: !selected
      //     ? Text(locale.search)
      //     : TextField(
      //         focusNode: textFieldFocusNode,
      //         textInputAction: TextInputAction.search,
      //         controller: textEditingController,
      //         textAlignVertical: TextAlignVertical.center,

      //         onChanged: (value) {
      //         },

      //         onSubmitted: (value) {
      //           focusNode.requestFocus();
      //         },

      //         style: const TextStyle(
      //           fontSize: 14.0,
      //           height: 1.0,
      //           // fontWeight: FontWeight.w500,
      //         ),
      //         cursorHeight: 20.0,
      //         cursorOpacityAnimates: true,

      //         decoration: InputDecoration(
      //           constraints: const BoxConstraints(
      //             maxWidth: 200.0,
      //             minWidth: 200.0,
      //           ),
      //           isCollapsed: true,
      //           contentPadding: const EdgeInsets.only(top: 0.0),

      //           hintText: locale.searchHint,
      //           hintStyle: TextStyle(
      //             fontSize: 14.0,
      //             height: 1.0,
      //             color: theme.colorScheme.outline,
      //             // fontWeight: FontWeight.w500,
      //           ),

      //           // border: OutlineInputBorder(),
      //           border: InputBorder.none,
      //         ),
      //       ),
      // ),
    );

    return TextButton(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      style: buttonStyle,
      onPressed: () {
        //tabsCubit.unfocusAll();
        tabsCubit.updateSelected(index);

        Future.delayed(KrsTheme.animationDuration, () {
          textFieldFocusNode.requestFocus();
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: Icon(
              Icons.search,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(
            height: 40.0,
            child: AnimatedSwitcher(
              duration: KrsTheme.animationDuration,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      axisAlignment: 0.0,
                      child: child,
                    ));
              },
              child: !selected
                  ? Text(
                      locale.search,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    )
                  : TextField(
                      focusNode: textFieldFocusNode,
                      textInputAction: TextInputAction.search,
                      controller: textEditingController,
                      onChanged: (value) {},
                      onSubmitted: (value) {
                        focusNode.requestFocus();
                      },
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(
                          maxWidth: 200.0,
                          minWidth: 200.0,
                          maxHeight: 40.0,
                          minHeight: 40.0,
                        ),
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.only(top: 8.0),
                        hintText: locale.searchHint,
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: theme.colorScheme.outline,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
            ),
          ),
        ],
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
      widthFactor: math.max(sizeFactor.value, 0.0),
      child: child,
    );
  }
}
