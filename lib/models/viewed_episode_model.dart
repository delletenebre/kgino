import 'package:hive_flutter/hive_flutter.dart';

part 'viewed_episode_model.g.dart';

@HiveType(typeId: 2)
class ViewedEpisodeModel {

  @HiveField(0)
  int id;

  @HiveField(1)
  int position;

  @HiveField(2)
  DateTime updatedAt;

  ViewedEpisodeModel(this.id, this.position, this.updatedAt);

}
