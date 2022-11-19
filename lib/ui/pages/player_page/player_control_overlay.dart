import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgino/ui/buttons/rounded_button.dart';
import 'package:kgino/ui/pages/player_page/player_invisible_touch_buttons.dart';
import 'package:kgino/ui/pages/player_page/player_play_pause_button.dart';
import 'package:kgino/ui/pages/player_page/player_progress_bar.dart';
import 'package:video_player/video_player.dart';

class PlayerControlOverlay extends StatefulWidget {

  /// обработчик запроса предыдущего видео
  final Function() onSkipPrevious;

  /// обработчик запроса следующего видео
  final Function() onSkipNext;

  /// обработчик при перемотке видео
  final Function(Duration) onSeek;

  /// обработчик при play/pause
  final Function() onPlayPause;

  /// обработчик при нажатии на обрабатываемую плеером клавишу
  final Function(LogicalKeyboardKey) onShowOverlay;
  
  /// контроллер видеоплеера
  final VideoPlayerController? playerController;

  /// название эпизода
  final Widget title;

  final bool isVisible;

  const PlayerControlOverlay({
    Key? key,
    required this.onSkipNext,
    required this.onSkipPrevious,
    required this.onSeek,
    required this.onPlayPause,
    this.playerController,
    required this.title,
    this.isVisible = false,
    required this.onShowOverlay,
  }) : super(key: key);

  @override
  _PlayerControlOverlayState createState() => _PlayerControlOverlayState();
}

class _PlayerControlOverlayState extends State<PlayerControlOverlay> {

  final overlayFocusNode = FocusScopeNode();
  final playButtonFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
    overlayFocusNode.dispose();
    playButtonFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.isVisible) {
      /// ^ если панель управления отображается
      
      /// запрашиваем фокус на кнопку остановки/продолжения проигрывания
      playButtonFocusNode.requestFocus();
    }

    return FocusScope(
      autofocus: true,
      node: overlayFocusNode,
      onKeyEvent: (focusNode, event) {
        widget.onShowOverlay(event.logicalKey);

        if (widget.isVisible) {
          return KeyEventResult.ignored;
        } else {
          return KeyEventResult.handled;
        }
        
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: widget.isVisible ? 1.0 : 0.0,
        child: Stack(
          children: [
            /// название сериала и эпизода
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: widget.isVisible ? 16.0 : 0.0,
              left: 16.0,
              right: 16.0,
              child: widget.title,
            ),

            /// остановить/продолжить воспроизведение
            Center(
              child: ValueListenableBuilder(
                valueListenable: widget.playerController!,
                builder: (context, VideoPlayerValue video, child) {
                  return PlayerPlayPauseButton(
                    focusNode: playButtonFocusNode,
                    isPlaying: video.isPlaying,
                    onPressed: () {
                      widget.onPlayPause.call();
                    },
                  );
                },
              ),
            ),


            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: widget.isVisible ? 16.0 : 0.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  PlayerProgressBar(
                    playerController: widget.playerController,
                    onSeek: (duration) {
                      widget.onSeek.call(duration);
                    },
                  ),

                  const SizedBox(height: 12.0),

                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),

                      /// кнопка предыдущего видео
                      RoundedButton(

                        onPressed: () {
                          /// вызываем пользовательский обработчик запроса
                          /// предыдущего видео
                          widget.onSkipPrevious.call();
                        },

                        child: const DecoratedIcon(Icons.skip_previous,
                          size: 24.0,
                          semanticLabel: 'Предыдущее видео',
                          shadows: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        
                      ),

                      const SizedBox(width: 16.0),

                      /// кнопка следующего видео
                      RoundedButton(

                        onPressed: () {
                          /// вызываем пользовательский обработчик запроса
                          /// следующего видео
                          widget.onSkipNext.call();
                        },

                        child: const DecoratedIcon(Icons.skip_next,
                          size: 24.0,
                          semanticLabel: 'Следующее видео',
                          shadows: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        
                      ),

                    ],
                  ),
                  
                ],
              ),
            ),

            /// виджет управления плеером жестами, когда панель управления
            /// скрыта
            PlayerInvisibleTouchButtons(
              enabled: !widget.isVisible,
              
              /// при касании к экрану
              onTap: () {
                widget.onShowOverlay(LogicalKeyboardKey.enter);
              },
              
              /// при запросе перемотки назад
              onReplay: () async {
                if (widget.playerController != null) {
                  
                  /// получаем текущую позицию просмотра
                  final position = await widget.playerController!.position;
                  final positionInSeconds = position?.inSeconds ?? 0;

                  /// перематываем назад
                  widget.onSeek(Duration(seconds: positionInSeconds - 30));
                  
                }
              },

              /// при запросе перемотки вперёд
              onForward: () async {
                if (widget.playerController != null) {
                  
                  /// получаем текущую позицию просмотра
                  final position = await widget.playerController!.position;
                  final positionInSeconds = position?.inSeconds ?? 0;

                  /// перематываем вперёд
                  widget.onSeek(Duration(seconds: positionInSeconds + 30));
                  
                }
              }
            ),

          ],
        ),
      ),
    );

  }
  
}