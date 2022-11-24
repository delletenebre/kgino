import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/ockg/ockg_movie.dart';
import '../../models/video_player_item.dart';
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
  late int _currentFileIndex;

  VideoPlayerItem _getVideoPlayerFile() {
    final currentFile = widget.movie.files[_currentFileIndex];
    final videoUrl = currentFile.path.replaceFirst('/home/video/', 'https://p1.oc.kg:8082/');
    
    String subtitle = '';
    if (widget.movie.files.length > 1) {
      subtitle = currentFile.name;
    }

    return VideoPlayerItem(
      videoUrl: videoUrl,
      title: widget.movie.name,
      subtitle: subtitle,
      startTime: 0,
    );
  }

  @override
  void initState() {
    _currentFileIndex = widget.fileIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return VideoPlayerView(
      videoPlayerItem: _getVideoPlayerFile(),
      onSkipNext: (_currentFileIndex + 1 < widget.movie.files.length) ? () async {
        /// запрашиваем следующий файл
        
        _currentFileIndex++;

        return _getVideoPlayerFile();
        
      } : null,
      onSkipPrevious: (_currentFileIndex > 0) ? () async {
        /// запрашиваем предыдущий файл
        
        _currentFileIndex--;

        return _getVideoPlayerFile();
      } : null,
    );
  }
}