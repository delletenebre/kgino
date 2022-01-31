import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgino/ui/buttons/rounded_button.dart';
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

  /// обработчик при нажатии на обрабатываемую плеером клавишу
  final Function(LogicalKeyboardKey) onShowOverlay;

  final VideoPlayerController? playerController;

  /// название эпизода
  final Widget title;

  final bool isVisible;

  const PlayerControlOverlay({
    Key? key,
    required this.onSkipNext,
    required this.onSkipPrevious,
    required this.onSeek,
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


  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
    overlayFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? content;

    if (!widget.isVisible) {
      overlayFocusNode.requestFocus();
    }

    if (widget.isVisible) {
      // content = Container(
      //   color: Colors.black.withOpacity(0.5),
      //   child: Stack(
      //     children: [
      //       /// название эпизода
      //       Positioned(
      //         top: 48.0,
      //         left: 16.0,
      //         right: 16.0,
      //         child: AnimatedOpacity(
      //           // If the widget is visible, animate to 0.0 (invisible).
      //           // If the widget is hidden, animate to 1.0 (fully visible).
      //           opacity: 1.0,
      //           duration: const Duration(milliseconds: 500),
      //           child: widget.title,
      //         ),
      //       ),

      //       /// управление пауза/запустить/перемотать вперёд/перемотать назад
      //       Row(
      //         children: [
                
      //           /// перемотать назад на 30 секунд
      //           Expanded(
      //             child: GestureDetector(
      //               behavior: HitTestBehavior.translucent,

      //               onDoubleTap: () {
      //                 debugPrint('onDoubleTap replay');
      //               },
                    
      //               child: const SizedBox(
      //                 height: double.maxFinite,
      //                 child: Icon(Icons.replay_10),
      //               ),
      //             ),
      //           ),

      //           /// остановить/продолжить воспроизведение
      //           Center(
      //             child: PlayerPlayPauseButton(
      //                 key: UniqueKey(),
      //                 isPlaying: widget.playerController?.value.isPlaying ?? false,
      //                 onPressed: () {
      //                   if (widget.playerController?.value.isPlaying ?? false) {
      //                     widget.playerController?.pause();
      //                   } else {
      //                     widget.playerController?.play();
      //                   }

      //                   setState(() {
      //                   });
      //                 },
      //               )
      //           ),

      //           /// перемотать вперёд на 30 секунд
      //           Expanded(
      //             child: GestureDetector(
      //               behavior: HitTestBehavior.translucent,
                    
      //               onDoubleTap: () {
      //                 debugPrint('onDoubleTap forward');
      //               },
                    
      //               child: const SizedBox(
      //                 height: double.maxFinite,
      //                 child: Icon(Icons.forward_10),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),

      //       /// progress bar, кнопки предыдущего/следующего видео
      //       Positioned(
      //         bottom: 48.0,
      //         left: 16.0,
      //         right: 16.0,
      //         child: Column(
      //             children: [
      //               PlayerProgressBar(
      //                 playerController: widget.playerController,
      //                 onSeek: (duration) {
      //                   widget.onSeek.call(duration);
      //                 },
      //               ),

      //               const SizedBox(height: 12.0),

      //               Row(
      //                 children: [
      //                   const Expanded(
      //                     child: SizedBox(),
      //                   ),

      //                   /// кнопка предыдущего видео
      //                   CircleButton(
      //                     onPressed: () {
      //                       /// вызываем пользовательский обработчик запроса
      //                       /// предыдущего видео
      //                       widget.onSkipPrevious.call();
      //                     },
      //                     child: const Icon(Icons.skip_previous,
      //                       semanticLabel: 'Предыдущее видео',
      //                     ),
                          
      //                   ),

      //                   const SizedBox(width: 12.0),

      //                   /// кнопка следующего видео
      //                   CircleButton(
      //                     onPressed: () {
      //                       /// вызываем пользовательский обработчик запроса
      //                       /// следующего видео
      //                       widget.onSkipNext.call();
      //                     },
      //                     child: const Icon(Icons.skip_next,
      //                       semanticLabel: 'Следующее видео',
      //                     ),
                          
      //                   ),

      //                 ],
      //               ),

                    
      //             ],
      //         ),
      //       ),
            
      //     ],
      //   ),
      // );
    }

    return FocusScope(
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
              top: widget.isVisible ? 48.0 : 0.0,
              left: 16.0,
              right: 16.0,
              child: widget.title,
            ),

            /// остановить/продолжить воспроизведение
            Center(
              child: PlayerPlayPauseButton(
                isPlaying: widget.playerController?.value.isPlaying ?? false,
                onPressed: () {
                  if (widget.playerController?.value.isPlaying ?? false) {
                    widget.playerController?.pause();
                  } else {
                    widget.playerController?.play();
                  }

                  setState(() {
                  });
                },
              )
            ),


            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: widget.isVisible ? 48.0 : 0.0,
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
                        child: const Icon(Icons.skip_previous,
                          semanticLabel: 'Предыдущее видео',
                        ),
                        
                      ),

                      const SizedBox(width: 12.0),

                      /// кнопка следующего видео
                      RoundedButton(
                        onPressed: () {
                          /// вызываем пользовательский обработчик запроса
                          /// следующего видео
                          widget.onSkipNext.call();
                        },
                        child: const Icon(Icons.skip_next,
                          semanticLabel: 'Следующее видео',
                        ),
                        
                      ),

                    ],
                  ),

                  
                ],
              ),
            ),

          ],
        ),
      ),
    );


    // return RawKeyboardListener(
    //   autofocus: true,
    //   focusNode: FocusNode(),
      
    //   onKey: (event) {

    //     /// список клавиш, на которые следует реагировать
    //     final availableKeys = [
    //       LogicalKeyboardKey.arrowLeft,
    //       LogicalKeyboardKey.arrowRight,
    //       LogicalKeyboardKey.arrowUp,
    //       LogicalKeyboardKey.arrowDown,
    //       LogicalKeyboardKey.enter,
    //       LogicalKeyboardKey.numpadEnter,
    //     ];
        
    //     if (availableKeys.contains(event.logicalKey)) {
    //       widget.onShowOverlay(event.logicalKey);
    //     }
    //   },
    //   child: GestureDetector(
    //     excludeFromSemantics: true,
    //     behavior: HitTestBehavior.translucent,
    //     onTap: () {
    //       widget.onShowOverlay(LogicalKeyboardKey.enter);
    //     },
    //     child: content
    //   )
    // );
  }
  
}