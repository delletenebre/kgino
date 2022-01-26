import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  final String showId;
  final String initialId;

  const PlayerPage({
    Key? key,
    required this.showId,
    this.initialId = '',
  }) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
  with SingleTickerProviderStateMixin {
  
  late VideoPlayerController _playerController;
  late AnimationController _playPauseAnimationController;

  String initialId = '';

  /// список идентификаторов эпизодов плейлиста
  final playlistIds = <String>[];

  @override
  void initState() {
    super.initState();

    if (widget.showId.isEmpty) {
      /// ^ если не указан id сериала
      
      /// возвращаемся назад
      // TODO возможно лучше показать ошибку
      Get.back();
    
    } else {
      /// ^ если id сериала был передан
      
      /// получаем данные сериала (сезоны и эпизоды)
      TskgApi.getShow(widget.showId).then((show) {
        /// очищаем спискок идентификаторов эпизодов
        playlistIds.clear();

          
        for (final season in show.seasons) {
          /// ^ перебираем сезоны
          
          for (final episode in season.episodes) {
            /// ^ перебираем эпизоды
            
            /// добавляем id эпизода в список
            playlistIds.add(episode.id);
          }
        }

        if (playlistIds.isEmpty) {
          /// ^ если список эпизодов пуст
        
          /// возвращаемся назад
          // TODO возможно лучше показать ошибку
          Get.back();
        
        } else {
          /// ^ если есть элементы в списоке эпизодов
          
          if (widget.initialId.isNotEmpty && playlistIds.contains(widget.initialId)) {
            /// ^ если передали id желаемого эпизода и он есть в списке всех эпизодов
            
            initialId = widget.initialId;
          } else {
            /// ^ если не передали id желаемого эпизода или он не найден в
            /// общем списке

            /// запускаем первый по списку эпизодов
            initialId = playlistIds.first;
          }
        }
      });
    }

    _playPauseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 300),
    );

    _playerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _playerController.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even
      // before the play button has been pressed.
      setState(() {});
    });

    _playerController.addListener(() {
      
    });
  }

  @override
  void dispose() {
    super.dispose();
    _playPauseAnimationController.dispose();
    _playerController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: _playerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _playerController.value.aspectRatio,
                    child: VideoPlayer(_playerController),
                  )
                : Container(),
          ),

          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          changeIcon();

                          setState(() {
                            _playerController.value.isPlaying
                                ? _playerController.pause()
                                : _playerController.play();
                          });
                        },
                        child: AnimatedIcon(
                          size: 100,
                          color: Colors.green,
                          icon: AnimatedIcons.pause_play,
                          progress: _playPauseAnimationController,
                        ),
                      ),
                      // FloatingActionButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       _playerController.value.isPlaying
                      //           ? _playerController.pause()
                      //           : _playerController.play();
                      //     });
                      //   },
                      //   child: AnimatedIcon(
                      //     icon: AnimatedIcons.pause_play
                      //     _playerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      //   ),
                      // ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

  bool isAnimating = false;
  void changeIcon() {
    //rebuilds UI with changing icon.
    setState(() {
      isAnimating = !isAnimating;
      isAnimating
          ? _playPauseAnimationController.forward()
          : _playPauseAnimationController.reverse();
    });
  }
}