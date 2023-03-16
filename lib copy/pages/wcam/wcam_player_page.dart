import 'package:flutter/material.dart';

import '../../models/episode_item.dart';
import '../../ui/video_player/video_player_view.dart';

class WcamPlayerPage extends StatefulWidget {
  final EpisodeItem item;

  const WcamPlayerPage({
    super.key,
    required this.item,
  });

  @override
  State<WcamPlayerPage> createState() => _WcamPlayerPageState();
}

class _WcamPlayerPageState extends State<WcamPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return VideoPlayerView(
      titleText: widget.item.name,
      subtitlesEnabled: false,
      isLiveStream: true,
      onInitialPlayableItem: () async => widget.item,

      onUpdatePosition: (episode, position, subtitlesEnabled) {
        
      }
    );
  }

}
