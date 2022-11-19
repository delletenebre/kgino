import 'package:hive_flutter/hive_flutter.dart';

part 'viewed_episode_model.g.dart';

@HiveType(typeId: 2)
class ViewedEpisodeModel {

  @HiveField(0)
  int id;

  @HiveField(1)
  int position;

  @HiveField(2)
  int duration;

  @HiveField(3)
  DateTime updatedAt;

  ViewedEpisodeModel({
    required this.id,
    this.position = 0,
    this.duration = 0,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

}
