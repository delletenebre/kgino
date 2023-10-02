import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/media_item.dart';
import '../../models/voice_acting.dart';
import '../../resources/krs_locale.dart';
import '../../utils.dart';
import 'krs_menu_button.dart';

class VoiceActingsButton extends HookWidget {
  final MediaItem mediaItem;
  final Function(VoiceActing voiceActing) onVoiceActingChange;

  const VoiceActingsButton(
    this.mediaItem, {
    super.key,
    required this.onVoiceActingChange,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    return KrsMenuButton<VoiceActing>(
      filled: true,
      items: mediaItem.voices,
      textBuilder: (item) => item.name,
      selectedValue: mediaItem.voice,
      onSelected: (voiceActing) {
        onVoiceActingChange(voiceActing);
      },
      child: Text(
        'Выбор аудио',
      ),
    );

    return FilledButton.tonal(
      onPressed: () {
        Utils.showModalRight(
          context: context,
          titleText: 'Выбор аудио',
          child: ListView(
            shrinkWrap: true,
            children: mediaItem.voices.map((voiceActing) {
              if (voiceActing.id == mediaItem.voice.id) {
                /// ^ если озвучка совпадает с текущей

                return FilledButton.tonalIcon(
                  autofocus: true,
                  icon: const Icon(Icons.check),
                  label: Text(voiceActing.name),
                  onPressed: () => Navigator.pop(context),
                );
              }

              return FilledButton.tonal(
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
      // icon: const Icon(Icons.mic),
      child: const Text('Выбрать озвучку'),
    );
  }
}
