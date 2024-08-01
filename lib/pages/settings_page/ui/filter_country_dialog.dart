import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/filmix_auth_provider.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/storage_provider.dart';
import '../../../ui/lists/kika_list_tile_checkbox.dart';

class FilterCountryDialog extends HookConsumerWidget {
  const FilterCountryDialog({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = Locale.of(context);

    final controllerState = ref.watch(filmixAuthProvider);
    final controller = ref.read(filmixAuthProvider.notifier);
    final focusNode = useFocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });

    final initialValue = [
      {'china': true, 'label': 'Китайские'},
      {'korea': true, 'label': 'Корейские'},
      {'japan': true, 'label': 'Японские'},
    ];

    return const SizedBox();

    // return ListView(
    //   shrinkWrap: true,
    //   children: initialValue.map((item) {
    //     return KikaListTileCheckbox(
    //       selected: ref
    //           .read(storageProvider)
    //           .readList<Map<String, dynamic>>('hide_china')[item.],
    //       onChaged: (checked) {
    //         ref.read(storageProvider).write('hide_china', checked);
    //       },
    //       title: 'Скрыть китайские',
    //     );
    //   })
    //   [

    //     KikaListTileCheckbox(
    //       selected: ref
    //           .read(storageProvider)
    //           .readBool('hide_korea', defaultValue: true),
    //       onChaged: (checked) {
    //         ref.read(storageProvider).write('hide_korea', checked);
    //       },
    //       title: 'Скрыть корейские',
    //     ),
    //     KikaListTileCheckbox(
    //       selected: ref
    //           .read(storageProvider)
    //           .readBool('hide_korea', defaultValue: true),
    //       onChaged: (checked) {
    //         ref.read(storageProvider).write('hide_korea', checked);
    //       },
    //       title: 'Скрыть корейские',
    //     ),
    //   ],
    // );
  }
}
