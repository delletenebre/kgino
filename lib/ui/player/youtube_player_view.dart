import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerView extends StatefulWidget {
  final String url;

  const YoutubePlayerView({
    super.key,
    required this.url,
  });

  @override
  _YoutubePlayerViewState createState() => _YoutubePlayerViewState();
}

class _YoutubePlayerViewState extends State<YoutubePlayerView> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        showLiveFullscreenButton: false,
        hideControls: true,
        isLive: true,
        forceHD: true,
      ),
    );
    //_controller.updateValue(_controller.value.copyWith(isFullScreen: true));
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.escape) ||
            event.isKeyPressed(LogicalKeyboardKey.backspace)) {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            context.pop();
          }
        }

        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        }

        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: YoutubePlayerBuilder(
            onExitFullScreen: () {
              /// The player forces portraitUp after exiting fullscreen.
              /// This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              Navigator.of(context).maybePop();
            },
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) => player,
          ),
        ),
      ),
    );
  }
}
