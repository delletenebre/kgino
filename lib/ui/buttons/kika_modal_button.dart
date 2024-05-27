import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../extensions/context_extensions.dart';
import '../lists/kika_list_tile.dart';

class KikaModalButton<T> extends HookWidget {
  final bool filled;
  final Widget? child;
  final Widget? icon;
  final T? selectedValue;
  final List<T> items;
  final String titleText;

  final String Function(T item) textBuilder;
  final void Function(T value) onSelected;
  final void Function()? onMenuOpen;
  final void Function()? onMenuClose;

  const KikaModalButton({
    super.key,
    this.filled = false,
    required this.textBuilder,
    required this.onSelected,
    required this.items,
    this.child,
    this.icon,
    this.titleText = '',
    this.selectedValue,
    this.onMenuOpen,
    this.onMenuClose,
  });

  @override
  Widget build(context) {
    // final theme = Theme.of(context);

    final scrollController = useScrollController();

    onPressed() {
      // Only show the menu if there is something to show
      if (items.isNotEmpty) {
        onMenuOpen?.call();

        if (selectedValue != null) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            final selectedIndex = items.indexOf(selectedValue!);
            scrollController.position.moveTo(selectedIndex * 20.0);
          });
        }

        context
            .showEndModal(
          titleText: titleText,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.separated(
              controller: scrollController,
              padding: const EdgeInsets.all(6.0),
              shrinkWrap: true,
              cacheExtent: 20.0,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return KikaListTile(
                  dense: true,
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
              separatorBuilder: (context, index) => const SizedBox(height: 4.0),
            ),
          ),
        )
            .then((value) {
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
