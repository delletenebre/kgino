import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/media_item_episode.dart';
import '../../../providers/providers.dart';
import '../../../resources/krs_theme.dart';

class PlaylistEpisodeTile extends HookConsumerWidget {
  final MediaItemEpisode episode;
  final String imageUrl;
  final void Function(bool hasFocus)? onFocusChange;
  final void Function() onTap;
  final bool selected;

  const PlaylistEpisodeTile({
    super.key,
    required this.episode,
    this.imageUrl = '',
    this.onFocusChange,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);

    final focused = useState(false);

    final seenEpisode = episode.saved(ref.read(storageProvider));
    final seen = seenEpisode?.viewed ?? 0.0;

    final title = 'Эпизод ${episode.episodeNumber}';
    final subtitle = episode.name.isNotEmpty ? episode.name : 'Нет названия';

    return Focus(
      onFocusChange: (hasFocus) {
        /// при получении фокуса
        focused.value = hasFocus;

        onFocusChange?.call(hasFocus);
      },
      onKeyEvent: (focusNode, event) {
        if ([LogicalKeyboardKey.enter, LogicalKeyboardKey.select]
            .contains(event.logicalKey)) {
          if (event is KeyDownEvent) {
            onTap.call();
          }
        }

        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          duration: kThemeAnimationDuration,
          scale: focused.value ? 1.1 : 1.0,
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            clipBehavior: Clip.antiAlias,
            width: TvUi.horizontalCardSize.width,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: focused.value
                  ? theme.colorScheme.inverseSurface
                  : selected
                      ? theme.colorScheme.secondaryContainer
                      : theme.colorScheme.secondaryContainer.withOpacity(0.24),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: AnimatedDefaultTextStyle(
              duration: kThemeAnimationDuration,
              style: TextStyle(
                color: focused.value
                    ? theme.colorScheme.surface
                    : selected
                        ? theme.colorScheme.onSecondaryContainer
                        : theme.colorScheme.onSurface,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// номер эпизода
                  Text(episode.episodeNumber.toString()),

                  /// отступ
                  const SizedBox(width: 24.0),

                  /// изображение эпизода
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      // gradient: const LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [Colors.green, Colors.blue],
                      // ),
                      color: Colors.black,
                    ),
                    child: const Icon(Icons.play_arrow_outlined),
                  ),

                  /// отступ
                  const SizedBox(width: 24.0),

                  /// название эпизода
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 24.0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              subtitle,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        // if (subtitle.isNotEmpty)
                        //   Opacity(
                        //     opacity: 0.8,
                        //     child: Text(
                        //       subtitle,
                        //       style: const TextStyle(
                        //         fontSize: 12.0,
                        //       ),
                        //     ),
                        //   ),
                        if (seen > 0.0)
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 12.0),
                            child: LinearProgressIndicator(
                              value: seen,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
