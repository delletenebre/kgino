import 'package:hive_flutter/hive_flutter.dart';
import 'package:kgino/models/viewed_episode_model.dart';

part 'viewed_show_model.g.dart';

@HiveType(typeId: 1)
class ViewedShowModel {

  @HiveField(0)
  String id;

  @HiveField(1)
  List<ViewedEpisodeModel> episodes;

  ViewedShowModel(this.id, this.episodes);

}
