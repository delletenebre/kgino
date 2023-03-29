import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../../models/kgino_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_storage.dart';
import '../../utils.dart';
import '../loading_indicator.dart';

class VoiceActingsButton extends HookWidget {
  final KginoItem kginoItem;
  final Function(KginoItem item) onVoiceActingChange;

  const VoiceActingsButton(this.kginoItem, {
    super.key,
    required this.onVoiceActingChange,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    return FilledButton.tonalIcon(
      onPressed: () {
        Utils.showModal(
          context: context,
          titleText: 'Выбор аудио',
          child: ListView(
            shrinkWrap: true,
            children: kginoItem.voiceActings.map((item) {
              if (item.voiceActing == kginoItem.voiceActing) {
                /// ^ если озвучка совпадает с текущей
                
                return FilledButton.icon(
                  autofocus: true,
                  icon: const Icon(Icons.check),
                  label: Text(kginoItem.voiceActing),
                  onPressed: () => Navigator.pop(context),
                );
              }

              return FilledButton(
                child: Text(item.voiceActing),
                onPressed: () async {
                  /// закрываем диалоговое окно
                  Navigator.pop(context);

                  /// вызываем пользовательский обработчик
                  onVoiceActingChange(item);

                },
              );
            }).toList(),
          ),
        );
      },
      icon: const Icon(Icons.mic),
      label: const Text('Выбрать озвучку'),
    );

  }
}