import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../models/media_item.dart';
import '../providers/providers.dart';
import '../ui/player/player_controls_overlay.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final MediaItem mediaItem;
  final int episodeIndex;

  /// начальная позиция просмотра видео
  final int initialPosition;

  /// обновление позиции без вопроса пользователю
  /// например, при смене качества видео
  final bool forcePositionUpdate;

  const PlayerPage({
    super.key,
    required this.mediaItem,
    this.episodeIndex = 0,
    this.initialPosition = 0,
    this.forcePositionUpdate = false,
  });
  @override
  ConsumerState createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  // Create a [Player] to control playback.
  final Player player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  late List<MediaItemEpisode> episodes;

  /// проигрываемый эпизод
  late MediaItemEpisode episode;

  /// индекс текущего сезона
  int currentSeasonIndex = 0;

  /// индекс текущего эпизода
  int currentEpisodeIndex = 0;

  @override
  void initState() {
    super.initState();

    episodes = widget.mediaItem.episodes();
    currentEpisodeIndex = widget.episodeIndex;
    episode = episodes[currentEpisodeIndex];

    widget.mediaItem
        .loadEpisodeUrl(
      ref: ref,
      episodeIndex: currentEpisodeIndex,
    )
        .then((episodeUrl) {
      debugPrint('Loaded episode url: $episodeUrl');
      player.open(Media(episodeUrl)).then((value) async {
        if (widget.initialPosition > 0 && widget.forcePositionUpdate) {
          /// ^ если задана позиция просмотра и быстрая перемотка

          /// дожидаемся буферизации
          await player.stream.buffer.first;

          /// перематываем с небольшой отмоткой назад
          await player.seek(Duration(
              seconds: widget.initialPosition > 2
                  ? widget.initialPosition - 2
                  : widget.initialPosition));
        }
      });
    });

    player.stream.buffering;

    // player.setSubtitleTrack(
    //   SubtitleTrack.uri(
    //     'https://www.iandevlin.com/html5test/webvtt/upc-video-subtitles-en.vtt',
    //     title: 'English',
    //     language: 'en',
    //   ),
    // );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  bool get hasPreviousEpisode => (currentEpisodeIndex - 1 > 0);
  bool get hasNextEpisode => (currentEpisodeIndex + 1 < episodes.length);

  void skipNext() {
    currentEpisodeIndex++;

    /// переходим на страницу плеера фильма
    updateEpisode();
  }

  void skipPrevious() {
    currentEpisodeIndex--;

    /// переходим на страницу плеера фильма
    updateEpisode();
  }

  void updateEpisode({
    int position = 0,
    bool forcePositionUpdate = false,
  }) {
    /// переходим на страницу плеера фильма
    context.pushReplacementNamed(
      'player',
      queryParameters: {
        'episodeIndex': '$currentEpisodeIndex',
        'initialPosition': '$position',
        'forcePositionUpdate': '$forcePositionUpdate',
      },
      extra: widget.mediaItem,
    );
  }

  @override
  Widget build(context) {
    return Video(
      controller: controller,
      controls: (state) {
        return Material(
          color: Colors.transparent,
          child: PlayerControlsOverlay(
            title: widget.mediaItem.title,
            subtitle:
                'Сезон ${episode.seasonNumber} Эпизод ${episode.episodeNumber}',
            qualities: episode.qualities.sorted((a, b) => b - a),
            quality: widget.mediaItem.quality,
            onQualityChanged: (quality) {
              /// обновляем информацию о качестве видео
              widget.mediaItem.quality = quality;
              widget.mediaItem.save(ref.read(storageProvider));

              /// перезапускаем эпизод
              updateEpisode(
                position: controller.player.state.position.inSeconds,
                forcePositionUpdate: true,
              );
            },
            onSkipPrevious: hasPreviousEpisode ? skipPrevious : null,
            onSkipNext: hasNextEpisode ? skipNext : null,
            onSavePositionRequested: (position) {
              /// обновляем (если нужно) продолжительность эпизода
              if (episode.duration == 0) {
                episode.duration = controller.player.state.duration.inSeconds;
              }

              /// обновляем позицию просмотра для проигрываемого эпизода
              episode.position = position;

              /// сохраняем параметры проигрываемого эпизода
              episode.save(ref.read(storageProvider));
            },
          ),
        );
      },
      // controls: MaterialVideoControls,
    );
  }
}
