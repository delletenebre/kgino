import 'package:flutter/material.dart';

import '../models/playable_item.dart';
import '../ui/video_player/video_player_view.dart';

class PlayerPage extends StatelessWidget {
  final PlayableItem videoPlayerItem;

  const PlayerPage({
    super.key,
    required this.videoPlayerItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return VideoPlayerView(
    //   playableItem: videoPlayerItem,
    // );
  }

}