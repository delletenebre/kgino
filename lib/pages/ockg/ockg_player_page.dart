import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/seen_items_controller.dart';
import '../../models/ockg/ockg_file.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../models/playable_item.dart';
import '../../models/seen_item.dart';
import '../../ui/video_player/video_player_view.dart';

class OckgPlayerPage extends StatefulWidget {
  final OckgMovie movie;
  final int fileIndex;
  final String fileId;

  const OckgPlayerPage({
    super.key,
    required this.movie,
    this.fileIndex = 0,
    this.fileId = '',
  });

  @override
  State<OckgPlayerPage> createState() => _OckgPlayerPageState();
}

class _OckgPlayerPageState extends State<OckgPlayerPage> {
  late final List<OckgFile> _episodes;
  late final int _episodeCount;
  int _currentIndex = 0;
  bool _subtitlesEnabled = false;
  int _startTime = 0;

  @override
  void initState() {
    _currentIndex = widget.fileIndex;

    /// все эпизоды в одном списке
    _episodes = widget.movie.files;

    /// количество эпизодов
    _episodeCount = _episodes.length;

    /// контроллер просмотренных эпизодов
    final seenItemsController = GetIt.instance<SeenItemsController>();
    
    /// проверяем был ли фильм уже в просмотренных
    final seenShow = seenItemsController.findItemByKey(
      SeenItem.getKey(
        tag: SeenItem.ockgTag,
        id: widget.movie.movieId.toString(),
      )
    );
    
    if (seenShow != null) {
      /// ^ если фильм уже был в просмотренных
      
      /// восстонавливаем состояние субтитров (включены или выключены)
      _subtitlesEnabled = seenShow.subtitlesEnabled;
      
      /// проверяем был ли эпизод в просмотренных
      final seenEpisode = seenItemsController.findEpisode(
        tag: SeenItem.tskgTag,
        itemId: widget.movie.movieId,
        episodeId: widget.fileId,
      );

      if (seenEpisode != null) {
        /// ^ если эпизод уже был в просмотренных
        print('_startTime $_startTime');
        /// восстанавливаем время просмотра
        _startTime = seenEpisode.position;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// контроллер просмотренных эпизодов
    final seenEpisodesController = GetIt.instance<SeenItemsController>();

    return VideoPlayerView(
      onInitialPlayableItem: _getPlayableItem,
      onSkipNext: (_currentIndex + 1 < _episodeCount) ? () {
        /// переходим к следующему файлу
        setState(() {
          _startTime = 0;
          _currentIndex++;
        });

        return _getPlayableItem();
      } : null,
      onSkipPrevious: (_currentIndex > 0) ? () {
        /// переходим к предыдущему файлу
        setState(() {
          _startTime = 0;
          _currentIndex--;
        });

        return _getPlayableItem();
      } : null,
      onUpdatePosition: (episodeId, position, duration, subtitlesEnabled) {
        _subtitlesEnabled = subtitlesEnabled;

        seenEpisodesController.updatePosition(
          tag: SeenItem.ockgTag,
          parentId: widget.movie.movieId,
          episodeId: episodeId,
          name: widget.movie.name,
          position: position,
          duration: duration,
          subtitlesEnabled: _subtitlesEnabled,
        );
      }
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
      id: currentFile.fileId.toString(),
      videoUrl: videoUrl,
      title: widget.movie.name,
      subtitle: subtitle,
      subtitlesEnabled: _subtitlesEnabled,
      startTime: _startTime,
    );
  }
}