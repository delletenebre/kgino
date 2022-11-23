import 'package:flutter/material.dart';

import '../models/video_player_item.dart';
import '../ui/video_player/video_player_view.dart';

class PlayerPage extends StatelessWidget {
  final VideoPlayerItem videoPlayerItem;

  const PlayerPage({
    super.key,
    required this.videoPlayerItem,
  });

  @override
  Widget build(BuildContext context) {

    return VideoPlayerView(
      videoPlayerItem: videoPlayerItem,
    );
  }

}