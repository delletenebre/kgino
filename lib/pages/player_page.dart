import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/player_page/player_control_overlay.dart';
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

class _PlayerPageState extends State<PlayerPage> {
  
  VideoPlayerController? _playerController;

  String initialId = '';

  /// список идентификаторов эпизодов плейлиста
  final playlistIds = <String>[];

  /// индикатор загрузки данных
  bool _loading = true;

  void updateLoadingState(bool state) {
    setState(() {
      _loading = state;
    });
  }

  @override
  void initState() {
    super.initState();

    debugPrint('======================= widget.showId.isEmpty');

    if (widget.showId.isEmpty) {
      /// ^ если не указан id сериала
      
      /// возвращаемся назад
      // TODO возможно лучше показать ошибку
      Get.back();
    
    } else {
      /// ^ если id сериала был передан
      
      updateLoadingState(true);
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

        debugPrint('playlistIds: $playlistIds');

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

        updateLoadingState(false);
      });
    }

    _playerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _playerController?.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even
      // before the play button has been pressed.
      setState(() {});
    });

    // _playerController.addListener(() {
      
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _playerController?.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: _playerController?.value.isInitialized ?? false
                ? AspectRatio(
                    aspectRatio: _playerController!.value.aspectRatio,
                    child: VideoPlayer(_playerController!),
                  )
                : Container(),
          ),

          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: PlayerControlOverlay(

            )
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _loading
              ? Container(
                  width: 96.0,
                  height: 96.0,
                  child: const CircularProgressIndicator()
                )
              : const SizedBox(),
          ),
        ]
      ),
    );
  }

  
}