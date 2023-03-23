import 'package:freezed_annotation/freezed_annotation.dart';

import 'tskg_video.dart';

part 'tskg_episode_details.freezed.dart';
part 'tskg_episode_details.g.dart';

@freezed
class TskgEpisodeDetails with _$TskgEpisodeDetails {
  const TskgEpisodeDetails._();

  const factory TskgEpisodeDetails({
    
    @Default(0) int id,
    @Default('') String download,
    @Default(0) int duration,
    @Default('') String filename,
    @Default('') String fullname,
    @Default('') String link,
    @Default('') String name,
    
    @Default('') String title,
    required TskgVideo video,
    
    /// может быть bool/String
    //dynamic voice,

    /// может быть bool/String
    //dynamic subtitles,
    
    // TskgEpisodeOverlay overlay

    
  }) = _TskgEpisodeDetails;

  factory TskgEpisodeDetails.fromJson(Map<String, Object?> json)
      => _$TskgEpisodeDetailsFromJson(json);

  String get nameWithSeason {
    final regExp = RegExp(r'^.+?(\d+?x\d+?)$');
    
    if (regExp.hasMatch(fullname)) {
      return '${regExp.firstMatch(fullname)?.group(1) ?? ''} $name';
    }

    return name;
  }
}

// @JsonSerializable()
// class TskgEpisodeOverlay {
//   final int id;
//   final String img;
//   final String link;

//   TskgEpisodeOverlay(
//     this.id,
//     this.img,
//     this.link,
//   );

//   factory TskgEpisodeOverlay.fromJson(Map<String, dynamic> json) =>
//     _$TskgEpisodeOverlayFromJson(json);

//   Map<String, dynamic> toJson() => _$TskgEpisodeOverlayToJson(this);

// }
