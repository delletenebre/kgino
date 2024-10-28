class FilmixShowLink {
  final String link;
  final List<int> qualities;

  const FilmixShowLink({
    this.link = '',
    this.qualities = const [],
  });

  factory FilmixShowLink.fromJson(Map<String, dynamic> json) => FilmixShowLink(
        link: json['link'] as String? ?? '',
        qualities: (json['qualities'] as List<dynamic>?)
                ?.map((item) => int.parse('$item'))
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'link': link,
        'qualities': qualities,
      };

  @override
  String toString() => toJson().toString();
}
