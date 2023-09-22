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
  bool _visible = false;
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
        _progressBarFocusNode.requestFocus();
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
    final theme = Theme.of(context);

    return Focus(
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
      child: GestureDetector(
        onTap: () {
          showOverlay();
        },
        child: AnimatedOpacity(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOut,
          opacity: _visible ? 1.0 : 0.0,
          child: Stack(
            children: [
              // Fallback from the controls to the video & show/hide controls on tap.
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      _visible ? theme.colorScheme.surface : Colors.transparent,
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.36],
                  ),
                ),
              )),
              const Center(
                child: PlayPauseButton(),
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
                        onSkipNext: widget.onSkipNext,
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
                            OutlinedButton(
                              onPressed: () {
                                widget.onSkipPrevious?.call();
                              },
                              child: const Icon(Icons.skip_previous_outlined),
                            ),
                          if (widget.onSkipPrevious != null &&
                              widget.onSkipNext != null)
                            const SizedBox(width: 12.0),
                          if (widget.onSkipNext != null)
                            OutlinedButton(
                              onPressed: () {
                                widget.onSkipNext?.call();
                              },
                              child: const Icon(Icons.skip_next_outlined),
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
