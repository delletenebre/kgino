import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgino/ui/pages/player_page/video_progress_bar.dart';

class PlayerControlOverlay extends StatefulWidget {
  final Duration? totalVideoDuration;

  /// обработчик запроса предыдущего видео
  final Function() onSkipPrevious;

  /// обработчик запроса следующего видео
  final Function() onSkipNext;

  /// обработчик при перемотке видео
  final Function(Duration) onSeek;

  const PlayerControlOverlay({
    Key? key,
    this.totalVideoDuration,
    required this.onSkipNext,
    required this.onSkipPrevious,
    required this.onSeek,
  }) : super(key: key);

  @override
  _PlayerControlOverlayState createState() => _PlayerControlOverlayState();
}

class _PlayerControlOverlayState extends State<PlayerControlOverlay>
  with SingleTickerProviderStateMixin {

  late AnimationController _playPauseAnimationController;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _playPauseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _playPauseAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,

                  onDoubleTap: () {
                    debugPrint('onDoubleTap replay');
                  },
                  
                  child: const SizedBox(
                    height: double.maxFinite,
                    child: Icon(Icons.replay_10),
                  ),
                ),
              ),

              Center(
                child: Material(
                  color: Colors.transparent,

                  borderRadius: BorderRadius.circular(96.0),
                  elevation: 1,
                  shadowColor: theme.colorScheme.primary,
                  
                  child: InkWell(
                    borderRadius: BorderRadius.circular(96.0),
                    onTap: () {
                      changeIcon();
                    },
                    child: AnimatedIcon(
                      size: 100,
                      color: theme.colorScheme.primary,
                      icon: AnimatedIcons.pause_play,
                      progress: _playPauseAnimationController,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  
                  onDoubleTap: () {
                    debugPrint('onDoubleTap forward');
                  },
                  
                  child: const SizedBox(
                    height: double.maxFinite,
                    child: Icon(Icons.forward_10),
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 48.0,
            left: 16.0,
            right: 16.0,
            child: Column(
                children: [
                  RawKeyboardListener(
                    focusNode: focusNode,
                    onKey: (event) {
                      debugPrint('event: $event');
                      if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                        debugPrint('arrowLeft');
                      } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                        debugPrint('arrowRight');
                      }
                    },
                    child: ProgressBar(
                      progress: Duration(milliseconds: 1000),
                      total: widget.totalVideoDuration ?? Duration.zero,
                      onSeek: (duration) {
                        debugPrint('User selected a new time: $duration');

                        /// вызываем пользовательский обработчик перемотки видео
                        widget.onSeek.call(duration);
                      },
                    ),
                  ),

                  const SizedBox(height: 12.0),

                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),

                      OutlinedButton(
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

                      OutlinedButton(
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
                  )

                  
                ],
            ),
          ),
          
        ],
      ),
    );
  }

  bool isAnimating = false;
  void changeIcon() {
    debugPrint('changeIcon');
    //rebuilds UI with changing icon.
    setState(() {
      isAnimating = !isAnimating;
      isAnimating
          ? _playPauseAnimationController.forward()
          : _playPauseAnimationController.reverse();
    });
  }
}