import 'package:hive/hive.dart';

part 'tskg_seen_episode.g.dart';

@HiveType(typeId: 1)
class TskgSeenEpisode extends HiveObject {

  @HiveField(0)
  final int id;

  @HiveField(1)
  int position;
  
  TskgSeenEpisode({
    required this.id,
    required this.position,
  });

}
