
import 'package:json_annotation/json_annotation.dart';

part 'tskg_episode_details.g.dart';

@JsonSerializable()
class TskgEpisodeDetails {
  final String download;
  final int duration;
  final String filename;
  final String fullname;
  final int id;
  final String link;
  final TskgEpisodeOverlay overlay;
  final String name;
  final bool subtitles;
  final String title;
  final TskgEpisodeVideo video;
  final String voice;
  
  TskgEpisodeDetails({
    this.download = '',
    this.duration = 0,
    this.filename = '',
    this.fullname = '',
    this.id = 0,
    this.link = '',
    required this.overlay,
    this.name = '',
    this.subtitles = false,
    this.title = '',
    required this.video,
    this.voice = '',
  });

  factory TskgEpisodeDetails.fromJson(Map<String, dynamic> json) =>
    _$TskgEpisodeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TskgEpisodeDetailsToJson(this);
}


@JsonSerializable()
class TskgEpisodeOverlay {
  final int id;
  final String img;
  final String link;

  TskgEpisodeOverlay(
    this.id,
    this.img,
    this.link,
  );

  factory TskgEpisodeOverlay.fromJson(Map<String, dynamic> json) =>
    _$TskgEpisodeOverlayFromJson(json);

  Map<String, dynamic> toJson() => _$TskgEpisodeOverlayToJson(this);

}

@JsonSerializable()
class TskgEpisodeVideo {
  @JsonKey(name: 'HD')
  final bool hd;
  final TskgEpisodeVideoFiles files;
  final String mimetype;
  final String videotype;

  TskgEpisodeVideo(
    this.hd,
    this.files,
    this.mimetype,
    this.videotype,
  );

  factory TskgEpisodeVideo.fromJson(Map<String, dynamic> json) =>
    _$TskgEpisodeVideoFromJson(json);

  Map<String, dynamic> toJson() => _$TskgEpisodeVideoToJson(this);

}

@JsonSerializable()
class TskgEpisodeVideoFiles {
  @JsonKey(name: 'HD')
  final TskgEpisodeVideoFile hd;
  @JsonKey(name: 'SD')
  final TskgEpisodeVideoFile sd;

  TskgEpisodeVideoFiles(this.hd, this.sd);

  factory TskgEpisodeVideoFiles.fromJson(Map<String, dynamic> json) =>
    _$TskgEpisodeVideoFilesFromJson(json);

  Map<String, dynamic> toJson() => _$TskgEpisodeVideoFilesToJson(this);

}

@JsonSerializable()
class TskgEpisodeVideoFile {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: '')
  final String server;

  @JsonKey(defaultValue: '')
  final String url;

  TskgEpisodeVideoFile(this.id, this.server, this.url);

  factory TskgEpisodeVideoFile.fromJson(Map<String, dynamic> json) =>
    _$TskgEpisodeVideoFileFromJson(json);

  Map<String, dynamic> toJson() => _$TskgEpisodeVideoFileToJson(this);

}
