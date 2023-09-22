import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

import '../../resources/constants.dart';
import 'controls/play_pause_button.dart';
import 'controls/player_progress_bar.dart';

// void useInterval(VoidCallback callback, Duration delay) {
//   final savedCallback = useRef(callback);
//   savedCallback.value = callback;

//   useEffect(() {
//     final timer = Timer.periodic(delay, (_) => savedCallback.value());
//     return timer.cancel;
//   }, [delay]);
// }

class PlayerControlsOverlay extends StatefulHookConsumerWidget {
  final Function()? onSkipNext;
  final Function()? onSkipPrevious;

  const PlayerControlsOverlay({
    super.key,
    this.onSkipNext,
    this.onSkipPrevious,
  });

  @override
  ConsumerState<PlayerControlsOverlay> createState() =>
      _PlayerControlsOverlayState();
}

class _PlayerControlsOverlayState extends ConsumerState<PlayerControlsOverlay> {
  Timer? _visibilityTimer;
  bool _visible = true;
  final _progressBarFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOverlay();
    });
    super.initState();
  }

  @override
  void dispose() {
    _visibilityTimer?.cancel();
    _progressBarFocusNode.dispose();
    super.dispose();
  }

  void showOverlay() {
    if (!_visible) {
      setState(() {
        _visible = true;
      });
    }
    _visibilityTimer?.cancel();

    if (controller(context).player.state.playing) {
      _visibilityTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          _visible = false;
        });
      });
    }
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        /// вызываем обработчик нажатия на play/pause
        // widget.onPlayPause.call();

        // /// ставим фокус на ProgressBar
        // _progressBarFocusNode.requestFocus();

        showOverlay();
      },
      child: Focus(
        autofocus: true,
        skipTraversal: true,
        onKey: (node, event) {
          if (!_visible) {
            /// ^ если оверлей не был виден пользователю

            if (event.isKeyPressed(LogicalKeyboardKey.select) ||
                event.isKeyPressed(LogicalKeyboardKey.enter)) {
              /// ^ если был нажат Enter

              // /// вызываем обработчик нажатия на play/pause
              // widget.onPlayPause.call();

              /// ставим фокус на ProgressBar
              _progressBarFocusNode.requestFocus();

              return KeyEventResult.handled;
            }
          }

          if (event.isKeyPressed(LogicalKeyboardKey.escape) ||
              event.isKeyPressed(LogicalKeyboardKey.backspace)) {
            // if (widget.playerController == null || !widget.playerController!.value.isPlaying) {
            //   Navigator.of(context).pop();
            // } else {
            //   widget.playerController?.pause();
            // }
          }

          if (event.isKeyPressed(LogicalKeyboardKey.space)) {
            controller(context).player.playOrPause();
          }

          // if (widget.playerController != null) {

          //   if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          //     if (widget.playerController!.value.isPlaying) {
          //       widget.playerController?.pause();
          //     } else {
          //       widget.playerController?.play();
          //     }
          //   }

          //   if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          //     widget.playerController!.position.then((position) {
          //       widget.playerController?.seekTo(Duration(seconds: position!.inSeconds + 10));
          //     });
          //   }

          //   if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          //     widget.playerController!.position.then((position) {
          //       widget.playerController?.seekTo(Duration(seconds: position!.inSeconds - 10));
          //     });
          //   }
          // }

          showOverlay();

          return KeyEventResult.ignored;
        },
        child: AnimatedOpacity(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOut,
          opacity: _visible ? 1.0 : 0.0,
          child: Stack(
            children: [
              // Fallback from the controls to the video & show/hide controls on tap.

              Center(
                child: StreamBuilder(
                  stream: controller(context).player.stream.playing,
                  builder: (context, playing) => PlayPauseButton(
                    isPlaying: playing.data == true,
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     videoState.widget.controller.player.playOrPause();
                //   },
                //   icon: StreamBuilder(
                //     stream: videoState.widget.controller.player.stream.playing,
                //     builder: (context, playing) => Icon(
                //       playing.data == true ? Icons.pause : Icons.play_arrow,
                //     ),
                //   ),
                //   // It's not necessary to use [StreamBuilder] or to use [Player] & [VideoController] from [state].
                //   // [StreamSubscription]s can be made inside [initState] of this widget.
                // ),
              ),
              Positioned(
                  bottom: TvUi.vPadding,
                  left: TvUi.hPadding,
                  right: TvUi.hPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PlayerProgressBar(
                        focusNode: _progressBarFocusNode,
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text('BACK'),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          if (widget.onSkipPrevious != null)
                            FilledButton(
                              onPressed: () {
                                widget.onSkipPrevious?.call();
                              },
                              child: Icon(Icons.skip_previous_outlined),
                            ),
                          if (widget.onSkipNext != null)
                            FilledButton(
                              onPressed: () {
                                widget.onSkipNext?.call();
                              },
                              child: Icon(Icons.skip_next_outlined),
                            ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
