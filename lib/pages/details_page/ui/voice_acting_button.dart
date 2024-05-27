import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../models/media_item.dart';
import '../../../providers/locale_provider.dart';
import '../../../ui/buttons/kika_modal_button.dart';

class VoiceActingButton extends HookWidget {
  final MediaItem mediaItem;
  final Function(VoiceActing voiceActing) onVoiceActingChange;

  const VoiceActingButton(
    this.mediaItem, {
    super.key,
    required this.onVoiceActingChange,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Locale.of(context);

    return KikaModalButton<VoiceActing>(
      filled: true,
      items: mediaItem.voices,
      textBuilder: (item) => item.name,
      selectedValue: mediaItem.voiceActing,
      onSelected: (voiceActing) {
        /// вызываем пользовательский обработчик
        onVoiceActingChange(voiceActing);
      },
      titleText: locale.selectAudio,
      child: Text(locale.selectAudio),
    );
  }
}
