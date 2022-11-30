import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'tskg_favorite.freezed.dart';
part 'tskg_favorite.g.dart';

@freezed
class TskgFavorite extends HiveObject with _$TskgFavorite {
  
  TskgFavorite._();

  @HiveType(typeId: 0)
  factory TskgFavorite({
    @HiveField(0) required String showId,
    @HiveField(1) required String name,
    @HiveField(2) @Default(0) int episodeCount,
    @HiveField(3) required DateTime createdAt,
  }) = _TskgFavorite;

}
