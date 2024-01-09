import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../models/media_item.dart';
import '../../../resources/krs_locale.dart';
import '../../buttons/krs_menu_button.dart';

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
    final locale = KrsLocale.of(context);

    return KrsMenuButton<VoiceActing>(
      filled: true,
      items: mediaItem.voices,
      textBuilder: (item) => item.name,
      selectedValue: mediaItem.voiceActing,
      onSelected: (voiceActing) {
        /// вызываем пользовательский обработчик
        onVoiceActingChange(voiceActing);
      },
      child: Text(locale.selectAudio),
    );
  }
}
