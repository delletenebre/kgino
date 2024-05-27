import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../providers/locale_provider.dart';

class SubtitlesButton extends HookWidget {
  final bool? hasSubtitles;
  final void Function(bool enabled) onSubtitlesChanged;
  const SubtitlesButton({
    super.key,
    required this.hasSubtitles,
    required this.onSubtitlesChanged,
  });

  @override
  Widget build(context) {
    final locale = Locale.of(context);

    if (hasSubtitles == false) {
      return OutlinedButton.icon(
        onPressed: () async {
          /// вызываем пользовательский обработчик включения
          /// субтитров
          onSubtitlesChanged.call(true);
        },
        icon: const Icon(
          Icons.subtitles_outlined,
          size: 18.0,
        ),
        label: Text(locale.enableSubtitles),
      );
    }

    /// кнопка выключения субтитров
    if (hasSubtitles == true) {
      return OutlinedButton.icon(
        onPressed: () async {
          /// вызываем пользовательский обработчик
          /// выключения субтитров
          onSubtitlesChanged.call(false);
        },
        icon: const Icon(
          Icons.subtitles_off_outlined,
          size: 18.0,
        ),
        label: Text(locale.disableSubtitles),
      );
    }

    return const SizedBox.shrink();
  }
}
