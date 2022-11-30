import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'tskg_seen_episode.freezed.dart';
part 'tskg_seen_episode.g.dart';

@freezed
class TskgSeenEpisode extends HiveObject with _$TskgSeenEpisode {
  
  TskgSeenEpisode._();

  @HiveType(typeId: 1)
  factory TskgSeenEpisode({
    @HiveField(0) @Default(0) int id,
    @HiveField(1) @Default(0) int position,
  }) = _TskgSeenEpisode;

}
