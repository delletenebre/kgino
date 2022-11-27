import 'package:flutter/material.dart';

import '../../models/playable_item.dart';
import '../../models/tskg/tskg_show.dart';
import '../../ui/video_player/video_player_view.dart';

class TskgPlayerPage extends StatefulWidget {
  final int startTime;
  final int fileIndex;
  final TskgShow show;

  const TskgPlayerPage({
    super.key,
    required this.show,
    this.startTime = 0,
    this.fileIndex = 0,
  });

  @override
  State<TskgPlayerPage> createState() => _TskgPlayerPageState();
}

class _TskgPlayerPageState extends State<TskgPlayerPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.fileIndex;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return VideoPlayerView(
      onInitialPlayableItem: _getPlayableItem,
      onSkipNext: (_currentIndex + 1 < widget.show.seasons.length) ? () {
        /// переходим к следующему файлу
        setState(() {
          _currentIndex++;
        });

        return _getPlayableItem();
      } : null,
      onSkipPrevious: (_currentIndex > 0) ? () {
        /// переходим к предыдущему файлу
        setState(() {
          _currentIndex--;
        });

        return _getPlayableItem();
      } : null,
    );
  }

  Future<PlayableItem> _getPlayableItem() async {
    final currentFile = widget.show.seasons[_currentIndex];
    // TODO fix it
    final videoUrl = '';//currentFile.path.replaceFirst('/home/video/', 'https://p1.oc.kg:8082/');
    
    String subtitle = '';
    // if (widget.show.files.length > 1) {
    //   subtitle = currentFile.name;
    // }

    return PlayableItem(
      videoUrl: videoUrl,
      title: widget.show.title,
      subtitle: subtitle,
      startTime: widget.startTime,
    );
  }
}