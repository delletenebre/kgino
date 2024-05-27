import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/context_extensions.dart';
import '../../providers/providers.dart';
import '../../ui/lists/kika_list_tile.dart';
import '../../ui/lists/kika_list_tile_checkbox.dart';
import 'ui/filmix_account_dialog.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context, ref) {
    // final theme = Theme.of(context);

    final focusNode = useFocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.children.first.requestFocus();
    });

    return Material(
      color: Colors.transparent,
      child: Focus(
        focusNode: focusNode,
        canRequestFocus: false,
        skipTraversal: true,
        onFocusChange: (hasFocus) {},
        onKeyEvent: (node, event) {
          if (HardwareKeyboard.instance
              .isLogicalKeyPressed(LogicalKeyboardKey.escape)) {
            context.pop();
            return KeyEventResult.handled;
          }

          return KeyEventResult.ignored;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KikaListTile(
              //focusColor: theme.colorScheme.onSurface,
              onSelect: () {
                context.showModal(child: const FilmixAccountDialog());
              },

              title: 'Аккаунт Filmix',
            ),
            const SizedBox(height: 12.0),
            KikaListTileCheckbox(
              //focusColor: theme.colorScheme.onSurface,
              selected: ref
                  .read(storageProvider)
                  .readBool('time_enabled', defaultValue: true),
              onChaged: (checked) {
                ref.read(storageProvider).write('time_enabled', checked);
              },
              title: 'Отображать время',
            ),
          ],
        ),
      ),
    );
  }
}
