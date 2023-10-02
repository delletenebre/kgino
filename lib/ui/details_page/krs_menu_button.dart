import 'package:flutter/material.dart';

import '../cards/krs_list_tile.dart';

class KrsMenuButton<T> extends StatelessWidget {
  final Widget? child;
  final T? selectedValue;
  final List<T> items;
  final String Function(T item) textBuilder;
  final T Function(T item) valueBuilder;
  final void Function(T value) onSelected;

  const KrsMenuButton({
    super.key,
    required this.textBuilder,
    required this.valueBuilder,
    required this.onSelected,
    required this.items,
    this.child,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: () {
        final RenderBox button = context.findRenderObject()! as RenderBox;
        final RenderBox overlay = Navigator.of(context)
            .overlay!
            .context
            .findRenderObject()! as RenderBox;

        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button.localToGlobal(Offset.zero, ancestor: overlay),
            button.localToGlobal(button.size.bottomRight(Offset.zero),
                ancestor: overlay),
          ),
          Offset.zero & overlay.size,
        );
        final List<PopupMenuEntry> menuItems = items.map((item) {
          final value = valueBuilder(item);
          return PopupMenuItem(
            value: value,
            height: 56,
            enabled: false,
            child: KrsListTile(
              onTap: () {
                onSelected.call(value);
              },
              selected: (value == selectedValue),
              showSelectedIcon: true,
              title: textBuilder(item),
            ),
          );
        }).toList();

        // Only show the menu if there is something to show
        if (menuItems.isNotEmpty) {
          showMenu(
            color: theme.colorScheme.surface,
            context: context,
            elevation: 0.0,
            // shadowColor: widget.shadowColor ??
            //     popupMenuTheme.shadowColor,
            // surfaceTintColor: widget.surfaceTintColor ??
            //     popupMenuTheme.surfaceTintColor,
            items: menuItems,
            //initialValue: selectedValue,
            position: position,
            // shape: widget.shape ?? popupMenuTheme.shape,
            // color: widget.color ?? popupMenuTheme.color,
            // constraints: widget.constraints,
            // clipBehavior: widget.clipBehavior,
          ).then<void>((newValue) {
            // if (!mounted) {
            //   return null;
            // }
            if (newValue == null) {
              // widget.onCanceled?.call();
              return null;
            }
            // widget.onSelected?.call(newValue);
          });
        }
      },
      child: child ?? Text('$selectedValue'),
    );
  }
}
