import 'package:hive_flutter/hive_flutter.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavoriteModel {

  @HiveField(0)
  String showId;

  @HiveField(1)
  String title;

  @HiveField(2)
  int episodesCount;

  FavoriteModel(this.showId, this.title, this.episodesCount);

}