import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/kgino_item.dart';
import '../../models/voice_acting.dart';
import '../../resources/krs_locale.dart';
import '../../utils.dart';

class VoiceActingsButton extends HookWidget {
  final KginoItem kginoItem;
  final Function(VoiceActing voiceActing) onVoiceActingChange;

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
            children: kginoItem.voiceActings.values.map((voiceActing) {
              if (voiceActing.id == kginoItem.voiceActing) {
                /// ^ если озвучка совпадает с текущей
                
                return FilledButton.icon(
                  autofocus: true,
                  icon: const Icon(Icons.check),
                  label: Text(voiceActing.name),
                  onPressed: () => Navigator.pop(context),
                );
              }

              return FilledButton(
                child: Text(voiceActing.name),
                onPressed: () async {
                  /// закрываем диалоговое окно
                  Navigator.pop(context);

                  /// вызываем пользовательский обработчик
                  onVoiceActingChange(voiceActing);

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