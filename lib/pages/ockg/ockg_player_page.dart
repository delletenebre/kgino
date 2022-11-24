import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/ockg/ockg_movie.dart';
import '../../models/video_player_item.dart';
import '../../ui/video_player/video_player_view.dart';

class OckgPlayerPage extends StatelessWidget {
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
  Widget build(BuildContext context) {

    final currentFile = movie.files[fileIndex];
    final videoUrl = currentFile.path.replaceFirst('/home/video/', 'https://p1.oc.kg:8082/');
    
    String subtitle = '';
    if (movie.files.length > 1) {
      subtitle = currentFile.name;
    }

    final videoPlayerItem = VideoPlayerItem(
      videoUrl: videoUrl,
      title: movie.name,
      subtitle: subtitle,
      startTime: startTime,
    );

    return VideoPlayerView(
      videoPlayerItem: videoPlayerItem,
      onSkipNext: (fileIndex + 1 < movie.files.length) ? () {
        /// переходим к следующему файлу
        context.replaceNamed('ockgMoviePlayer',
          params: {
            'id': '${movie.movieId}',    
          },
          queryParams: {
            'startTime': 0.toString(),
            'fileIndex': (fileIndex + 1).toString(),
          },
          extra: movie,
        );
      } : null,
      onSkipPrevious: (fileIndex > 0) ? () {
        /// переходим к предыдущему файлу
        context.replaceNamed('ockgMoviePlayer',
          params: {
            'id': '${movie.movieId}',    
          },
          queryParams: {
            'startTime': 0.toString(),
            'fileIndex': (fileIndex - 1).toString(),
          },
          extra: movie,
        );
      } : null,
    );
  }

}