// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tskg_video.freezed.dart';
part 'tskg_video.g.dart';

@freezed
class TskgVideo with _$TskgVideo {
  const factory TskgVideo({
    @JsonKey(name: 'HD') @Default(false) bool hd,
    required TskgVideoFiles files,
    @Default('') String mimetype,
    @Default('') String videotype,
    @Default('') String subtitles,

  }) = _TskgVideo;

  factory TskgVideo.fromJson(Map<String, Object?> json)
      => _$TskgVideoFromJson(json);
}

@freezed
class TskgVideoFiles with _$TskgVideoFiles {
  const factory TskgVideoFiles({
    @JsonKey(name: 'HD') required TskgVideoFile hd,
    @JsonKey(name: 'SD') required TskgVideoFile sd,

  }) = _TskgVideoFiles;

  factory TskgVideoFiles.fromJson(Map<String, Object?> json)
      => _$TskgVideoFilesFromJson(json);
}

@freezed
class TskgVideoFile with _$TskgVideoFile {
  const factory TskgVideoFile({
    @Default(0) int id,
    @Default('') String server,
    String? url,

  }) = _TskgVideoFile;

  factory TskgVideoFile.fromJson(Map<String, Object?> json)
      => _$TskgVideoFileFromJson(json);
}
