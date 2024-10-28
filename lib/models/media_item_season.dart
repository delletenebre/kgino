import 'media_item_episode.dart';

class MediaItemSeason {
  final String id;
  final String name;
  final List<MediaItemEpisode> episodes;

  const MediaItemSeason({
    this.id = '',
    this.name = '',
    this.episodes = const [],
  });

  factory MediaItemSeason.fromJson(Map<String, dynamic> json) =>
      MediaItemSeason(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        episodes: (json['episodes'] as List<dynamic>?)
                ?.map((item) =>
                    MediaItemEpisode.fromJson(item as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'episodes': episodes.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => toJson().toString();

  String nameOr(String name) {
    if (this.name.toLowerCase().startsWith('сезон')) {
      return this.name;
    }

    return name;
  }
}
