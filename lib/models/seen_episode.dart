import 'package:hive/hive.dart';

part 'seen_episode.g.dart';

@HiveType(typeId: 1)
class SeenEpisode extends HiveObject {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String parentId;

  @HiveField(2)
  int position;

  @HiveField(3)
  final int duration;
  
  SeenEpisode({
    required this.id,
    required this.parentId,
    required this.position,
    required this.duration,
  });

}
