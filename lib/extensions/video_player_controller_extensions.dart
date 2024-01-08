import 'package:video_player/video_player.dart';

extension VideoPlayerControllerExtensions on VideoPlayerController {
  void playOrPause() {
    if (value.isInitialized) {
      if (value.isPlaying) {
        pause();
      } else {
        play();
      }
    }
  }
}
