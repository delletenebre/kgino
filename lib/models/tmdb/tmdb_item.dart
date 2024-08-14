class TmdbItem {
  static const imageUrl = 'https://image.tmdb.org/t/p/original/';

  final int id;
  final String name;
  final String overview;
  final String? backdropPath;
  final String? posterPath;
  // final List<int> genreIds;
  // final List<String> originCountry;
  // final bool adult;
  // final DateTime firstAirDate;
  final double voteAverage;

  TmdbItem({
    this.id = 0,
    this.name = '',
    this.overview = '',
    this.backdropPath,
    this.posterPath,
    this.voteAverage = 0.0,
    // DateTime? firstAirDate,

    // }) : firstAirDate = firstAirDate ?? DateTime.now();
  });

  factory TmdbItem.fromJson(Map<String, Object?> json) => TmdbItem(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        overview: json['overview'] as String? ?? '',
        backdropPath: json['backdrop_path'] as String?,
        posterPath: json['poster_path'] as String?,
        // firstAirDate: DateTime.parse(json['first_air_date'] as String),
        voteAverage: double.tryParse(json['vote_average'].toString()) ?? 0.0,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'overview': overview,
        // 'adult': adult,
        'backdrop_path': backdropPath,
        'poster_path': posterPath,
        // 'first_air_date': firstAirDate,
        'vote_average': voteAverage,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  String? get backdropUrl =>
      backdropPath == null ? null : '$imageUrl$backdropPath';
  String? get posterUrl => posterPath == null ? null : '$imageUrl$posterPath';
}
