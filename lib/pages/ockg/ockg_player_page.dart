import 'package:flutter/material.dart';

import '../../models/ockg/ockg_movie.dart';
import '../../models/playable_item.dart';
import '../../ui/video_player/video_player_view.dart';

class OckgPlayerPage extends StatefulWidget {
  final int startTime;
  final int fileIndex;
  final OckgMovie movie;

  const OckgPlayerPage({
    super.key,
    required this.movie,
    this.startTime = 0,
    this.fileIndex = 0,
  });

  @override
  State<OckgPlayerPage> createState() => _OckgPlayerPageState();
}

class _OckgPlayerPageState extends State<OckgPlayerPage> {
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
      onSkipNext: (_currentIndex + 1 < widget.movie.files.length) ? () {
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
    final currentFile = widget.movie.files[_currentIndex];
    final videoUrl = currentFile.path.replaceFirst('/home/video/', 'https://p1.oc.kg:8082/');
    
    String subtitle = '';
    if (widget.movie.files.length > 1) {
      subtitle = currentFile.name;
    }

    return PlayableItem(
      videoUrl: videoUrl,
      title: widget.movie.name,
      subtitle: subtitle,
      startTime: widget.startTime,
    );
  }
}