import 'package:hive/hive.dart';

part 'seen_item.g.dart';

@HiveType(typeId: 1)
class SeenItem extends HiveObject {
  static const tskgTag = 'tskg';
  static const ockgTag = 'ockg';
  
  static String getKey({
    required String tag,
    required String id,
  }) => '$tag-$id';


  /// название сервиса
  @HiveField(0)
  final String tag;

  /// идентификатор сериала (или фильма)
  @HiveField(1)
  final String id;

  /// название сериала (или фильма)
  @HiveField(2)
  final String name;

  /// включены или выключены субтитры
  @HiveField(3)
  bool subtitlesEnabled;

  /// дата последнего просмотра
  @HiveField(4)
  DateTime updatedAt;

  /// список просмотренных эпизодов
  @HiveField(5)
  final Map<String, SeenEpisode> episodes;
  
  SeenItem({
    required this.tag,
    required this.id,
    required this.name,
    required this.updatedAt,
    required this.episodes,
    required this.subtitlesEnabled,
  });

}

@HiveType(typeId: 2)
class SeenEpisode extends HiveObject {

  /// время просмотра эпизода (в секундах)
  @HiveField(0)
  int position;

  /// продолжительность эпизода (в секундах)
  @HiveField(1)
  final int duration;

  /// время обновления данных
  @HiveField(2)
  DateTime updatedAt;
  
  SeenEpisode({
    required this.position,
    required this.duration,
    required this.updatedAt,
  });

  /// просмотренная позиция в пределах от 0 до 1
  /// + 0.01 чтобы не получилось деления на ноль
  double get percentPosition => position / (duration + 0.01);

}
