import 'package:hive_flutter/hive_flutter.dart';
import 'package:kgino/models/viewed_episode_model.dart';

part 'viewed_show_model.g.dart';

@HiveType(typeId: 1)
class ViewedShowModel {

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<ViewedEpisodeModel> episodes;

  @HiveField(3)
  DateTime updatedAt;

  ViewedShowModel({
    required this.id,
    required this.title,
    List<ViewedEpisodeModel>? episodes,
    DateTime? updatedAt,
  }) : 
    updatedAt = updatedAt ?? DateTime.now(),
    episodes = episodes ?? [];

}
