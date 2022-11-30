import 'package:hive/hive.dart';

part 'tskg_favorite.g.dart';

@HiveType(typeId: 0)
class TskgFavorite extends HiveObject {

  @HiveField(0)
  final String showId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  int episodeCount;

  @HiveField(3)
  final DateTime createdAt;
  
  TskgFavorite({
    required this.showId,
    required this.name,
    this.episodeCount = 0,
    required this.createdAt,
  });

}
