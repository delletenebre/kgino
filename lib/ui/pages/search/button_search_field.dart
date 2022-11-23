
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/ockg/ockg_search_controller.dart';
import '../../../resources/krs_theme.dart';

class ButtonSearchField extends StatefulWidget {
  final FocusNode focusNode;
  final String labelText;
  final Function(bool) onFocusChange;
  final VoidCallback? onPressed;
  final bool selected;
  final bool active;

  const ButtonSearchField({
    super.key,
    required this.focusNode,
    required this.labelText,
    required this.onFocusChange,
    required this.onPressed,
    required this.selected,
    required this.active,
  });

  @override
  State<ButtonSearchField> createState() => _ButtonSearchFieldState();
}

class _ButtonSearchFieldState extends State<ButtonSearchField> {
  final _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final styleOpacity = widget.active ? 1.0 : 0.62;
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.only(
          left: 16.0,
          right: 24.0,
        )
      ),
      side: MaterialStateProperty.resolveWith((states) {
        if (widget.selected && widget.active) {
          return BorderSide(
            width: 1.0,
            color: theme.colorScheme.outline,
          );
        }

        return BorderSide.none;
      }),
      
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (widget.selected) {
          // if (widget.active) {
          //   return theme.colorScheme.primary;
          // } else {
            return theme.colorScheme.primary.withOpacity(0.12);
          // }
        }

        return Colors.transparent;
      }),

      foregroundColor: MaterialStateProperty.resolveWith((states) {
        // if (widget.active) {
        //   if (widget.selected) {
        //     return theme.colorScheme.onPrimary;
        //   } else {
        //     theme.colorScheme.onSecondaryContainer;
        //   }
        // } else {
          theme.colorScheme.onSecondaryContainer.withOpacity(0.12);
        // }
        
        return theme.colorScheme.onSecondaryContainer.withOpacity(styleOpacity);
      }),

      overlayColor: MaterialStateProperty.all(Colors.transparent),

      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        );
      }),
      
    );
    
    return TextButton(
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      style: buttonStyle,
      onPressed: () {
        Future.delayed(KrsTheme.animationDuration, () {
          if (mounted && widget.selected && widget.active) {
            _textFieldFocusNode.requestFocus();
          }
        });
        
      },
      child: AnimatedContainer(
        duration: KrsTheme.animationDuration,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.search),
            ),
            
            AnimatedCrossFade(
              duration: KrsTheme.animationDuration,
              alignment: Alignment.centerLeft,
              excludeBottomFocus: false,
              crossFadeState: widget.selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              firstChild: const Text('Поиск'),
              secondChild: Visibility(
                visible: widget.selected,
                child: TextField(
                  focusNode: _textFieldFocusNode,
                  textInputAction: TextInputAction.search,

                  onChanged: (searchQuery) {
                    context.read<OckgSearchController>().searchMovies(searchQuery);
                  },

                  onSubmitted: (searchQuery) {
                    context.read<OckgSearchController>().searchMovies(searchQuery);
                  },

                  style: const TextStyle(
                    fontSize: 14.0,
                  ),

                  decoration: InputDecoration(
                    constraints: const BoxConstraints(
                      maxWidth: 200.0,
                      minWidth: 100.0,
                      maxHeight: 40.0,
                      minHeight: 40.0,
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.only(top: 8.0),
                    // filled: true,

                    hintText: 'Название фильма, сериала',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: theme.colorScheme.outline,
                    ),

                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}