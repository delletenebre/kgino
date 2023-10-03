class MediaItemUrl {
  final String video;
  final String subtitles;

  MediaItemUrl({
    this.video = '',
    this.subtitles = '',
  });

  @override
  String toString() {
    return '{video: $video, subtitles: $subtitles}';
  }
}
