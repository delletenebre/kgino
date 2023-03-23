class CategoryListItem<T> {
  final String title;
  final List<T> items;
  final Future<List<T>>? itemsFuture;

  CategoryListItem({
    required this.title,
    this.items = const [],
    this.itemsFuture,
  });
}
