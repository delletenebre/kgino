import 'package:video_player/video_player.dart';

extension VideoPlayerControllerExtensions on VideoPlayerController? {
  void playOrPause() {
    if (this?.value.isInitialized == true) {
      if (this?.value.isPlaying == true) {
        this?.pause();
      } else {
        this?.play();
      }
    }
  }
}
