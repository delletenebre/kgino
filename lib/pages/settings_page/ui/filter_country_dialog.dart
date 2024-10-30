import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/storage_provider.dart';
import '../../../ui/lists/kika_list_tile_checkbox.dart';

class FilterCountryDialog extends HookConsumerWidget {
  const FilterCountryDialog({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final focusNode = useFocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });

    final initialValue = [
      {'id': 'china', 'enabled': true, 'label': 'Китайские'},
      {'id': 'korea', 'enabled': true, 'label': 'Корейские'},
      {'id': 'japan', 'enabled': true, 'label': 'Японские'},
    ];

    final settings = ref
        .read(storageProvider)
        .readList('hidden_categories', defaultValue: initialValue);

    return ListView(
      shrinkWrap: true,
      children: settings.map((item) {
        return KikaListTileCheckbox(
          selected: item['enabled'],
          onChaged: (checked) {
            settings.firstWhere((e) => e['id'] == item['id'])['enabled'] =
                checked;
            ref.read(storageProvider).write('hidden_categories', settings);
          },
          title: 'Скрыть ${item['label']}',
        );
      }).toList(),
    );
  }
}
