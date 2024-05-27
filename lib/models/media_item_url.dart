import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MediaItemUrl {
  final String video;
  final String subtitles;

  /// файл субтитров
  WebVTTCaptionFile? closedCaptionFile;

  MediaItemUrl({
    this.video = '',
    this.subtitles = '',
  });

  bool get hasSubtitles => subtitles.isNotEmpty;

  Future<ClosedCaptionFile> loadSubtitlesFile() async {
    if (hasSubtitles) {
      try {
        final data = NetworkAssetBundle(Uri.parse(subtitles));
        final newData = await data.load('');
        final fileContents = _getStringFromBytes(newData);
        return WebVTTCaptionFile(fileContents);
      } catch (exception) {
        /// do nothing
      }
    }

    return WebVTTCaptionFile('');
  }

  String _getStringFromBytes(ByteData data) {
    final buffer = data.buffer;
    var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return utf8.decode(list);
  }

  @override
  String toString() {
    return '{video: $video, subtitles: $subtitles}';
  }
}
