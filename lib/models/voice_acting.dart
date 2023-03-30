import 'season_item.dart';

// part 'voice_acting.g.dart';

class VoiceActing {

  /// идентификатор перевода
  final String id;

  /// название перевода
  final String name;

  /// сезоны в переводе
  List<SeasonItem> seasons;

  VoiceActing({
    required this.id,
    required this.name,
    this.seasons = const [],
  });

}
