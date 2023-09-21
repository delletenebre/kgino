import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../models/test/media_item.dart';
import '../ui/player/player_controls_overlay.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final MediaItem mediaItem;
  final int seasonIndex;
  final int episodeIndex;
  final int initialPosition;

  const PlayerPage({
    super.key,
    required this.mediaItem,
    this.seasonIndex = 0,
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

  /// индекс текущего сезона
  int currentSeasonIndex = 0;

  /// индекс текущего эпизода
  int currentEpisodeIndex = 0;

  @override
  void initState() {
    super.initState();

    currentSeasonIndex = widget.seasonIndex;
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
      seasonIndex: currentSeasonIndex,
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

  @override
  Widget build(context) {
    return Center(
      child: Video(
        controller: controller,
        controls: (state) {
          return PlayerControlsOverlay(state);
        },
        // controls: MaterialVideoControls,
      ),
    );
  }
}
