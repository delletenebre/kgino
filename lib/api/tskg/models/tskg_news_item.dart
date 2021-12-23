class TskgNewsItem {
  final DateTime date;
  final String badge;
  final String title;
  final String subtitle;
  final String genres;
  final String link;
  
  TskgNewsItem({
    required this.date,
    this.badge = '',
    this.title = '',
    this.subtitle = '',
    this.genres = '',
    this.link = '',
  });
}