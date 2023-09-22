import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../models/test/media_item.dart';
import '../models/test/media_item_episode.dart';
import '../ui/player/player_controls_overlay.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final MediaItem mediaItem;
  final int episodeIndex;
  final int initialPosition;

  const PlayerPage({
    super.key,
    required this.mediaItem,
    this.episodeIndex = 0,
    this.initialPosition = 0,
  });
  @override
  ConsumerState createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  // Create a [Player] to control playback.
  late final player;
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  late List<MediaItemEpisode> episodes;

  /// индекс текущего сезона
  int currentSeasonIndex = 0;

  /// индекс текущего эпизода
  int currentEpisodeIndex = 0;

  @override
  void initState() {
    super.initState();

    episodes = widget.mediaItem.episodes();
    currentEpisodeIndex = widget.episodeIndex;

    final playerConfiguration = PlayerConfiguration(
      // Supply your options:
      title: 'My awesome package:media_kit application',
      ready: () {
        print('The initialization is complete.');
      },
    );
    player = Player(
      configuration: playerConfiguration,
    );

    widget.mediaItem
        .loadEpisodeUrl(
      ref: ref,
      episodeIndex: currentEpisodeIndex,
    )
        .then((episodeUrl) {
      debugPrint('Loaded episode url: $episodeUrl');
      player.open(Media(episodeUrl));
    });

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

  void updateEpisode() {
    /// переходим на страницу плеера фильма
    context.pushReplacementNamed(
      'player',
      queryParameters: {
        'episodeIndex': '$currentEpisodeIndex',
      },
      extra: widget.mediaItem,
    );
  }

  @override
  Widget build(context) {
    return Video(
      controller: controller,
      controls: (state) {
        return PlayerControlsOverlay(
          title: widget.mediaItem.title,
          subtitle:
              'Сезон ${episodes[currentEpisodeIndex].seasonNumber} Эпизод ${episodes[currentEpisodeIndex].episodeNumber}',
          onSkipPrevious: hasPreviousEpisode ? skipPrevious : null,
          onSkipNext: hasNextEpisode ? skipNext : null,
        );
      },
      // controls: MaterialVideoControls,
    );
  }
}
