
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

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

    final tabsCubit = GetIt.instance<TabsCubit>();

    final selected = tabsCubit.state == index;
    final focusNode = tabsCubit.focusNodes[index];
    void onFocusChange(hasFocus) {
      if (hasFocus) {
        tabsCubit.updateSelected(index);
      }
    }

    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: 24.0,
        )
      ),
      
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return theme.colorScheme.primary.withOpacity(0.24);
        }
        
        if (selected) {
          return theme.colorScheme.primary.withOpacity(0.12);
        }

        return null;
      }),
    );
    
    return TextButton(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      style: buttonStyle,
      onPressed: () {
        tabsCubit.unfocusAll();
        tabsCubit.updateSelected(index);

        Future.delayed(KrsTheme.animationDuration, () {
          final selected = tabsCubit.state == index;
          if (selected) {
            textFieldFocusNode.requestFocus();
          }
        });
      },
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 8.0),
            child: Icon(Icons.search),
          ),
          
          AnimatedSwitcher(
            duration: KrsTheme.animationDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  axisAlignment: 1.0,
                  child: child,
                )
              );
            },
            child: !selected ? Text(locale.search, style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              )) : TextField(
              focusNode: textFieldFocusNode,
              textInputAction: TextInputAction.search,

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
        ],
      ),
    );
  }
}