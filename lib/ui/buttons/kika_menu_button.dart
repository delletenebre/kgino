import 'package:flutter/material.dart';

import '../lists/kika_list_tile.dart';

class KikaMenuButton<T> extends StatelessWidget {
  final bool filled;
  final Widget? child;
  final Widget? icon;
  final T? selectedValue;
  final List<T> items;
  final String Function(T item) textBuilder;
  final void Function(T value) onSelected;
  final void Function()? onMenuOpen;
  final void Function()? onMenuClose;

  const KikaMenuButton({
    super.key,
    this.filled = false,
    required this.textBuilder,
    required this.onSelected,
    required this.items,
    this.child,
    this.icon,
    this.selectedValue,
    this.onMenuOpen,
    this.onMenuClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    onPressed() {
      final button = context.findRenderObject()! as RenderBox;
      final overlay = Navigator.of(context).overlay!.context.findRenderObject()!
          as RenderBox;

      final position = RelativeRect.fromRect(
        Rect.fromPoints(
          button.localToGlobal(Offset.zero, ancestor: overlay),
          button.localToGlobal(button.size.bottomRight(Offset.zero),
              ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      );
      // final menuItems = items.map((item) {
      //   return PopupMenuItem(
      //     value: item,
      //     height: 56,
      //     enabled: false,
      //     child: KrsListTile(
      //       onTap: () {
      //         onSelected.call(item);
      //       },
      //       selected: (item == selectedValue),
      //       showSelectedIcon: true,
      //       title: textBuilder(item),
      //     ),
      //   );
      // }).toList();

      // Only show the menu if there is something to show
      if (items.isNotEmpty) {
        onMenuOpen?.call();
        showDialog<T>(
          context: context,
          barrierColor: theme.colorScheme.surface.withOpacity(0.99),
          barrierDismissible: true,
          builder: (context) => Stack(
            children: [
              Positioned(
                left: position.left,
                bottom: position.bottom,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  constraints: const BoxConstraints(
                    maxHeight: 480.0,
                    maxWidth: 280.0,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListView.separated(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return KikaListTile(
                        dense: true,
                        // onTap: () {
                        //   /// закрываем диалоговое окно
                        //   Navigator.of(context)
                        //       .pop((item == selectedValue) ? null : item);
                        // },
                        onSelect: () {
                          /// закрываем диалоговое окно
                          Navigator.of(context)
                              .pop((item == selectedValue) ? null : item);
                        },
                        selected: (item == selectedValue),
                        showSelectedIcon: true,
                        title: textBuilder(item),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 4.0),
                  ),
                ),
              ),
            ],
          ),
        ).then((value) {
          if (value != null) {
            onSelected.call(value);
          }
          onMenuClose?.call();
        });
      }
    }

    if (icon != null) {
      if (filled) {
        return FilledButton.tonalIcon(
          onPressed: onPressed,
          label: child ?? Text('$selectedValue'),
          icon: icon!,
        );
      } else {
        return OutlinedButton.icon(
          onPressed: onPressed,
          label: child ?? Text('$selectedValue'),
          icon: icon!,
        );
      }
    }

    if (filled) {
      return FilledButton.tonal(
        onPressed: onPressed,
        child: child ?? Text('$selectedValue'),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        child: child ?? Text('$selectedValue'),
      );
    }
  }
}
