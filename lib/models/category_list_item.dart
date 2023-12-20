import 'media_item.dart';

class CategoryListItem {
  final OnlineService onlineService;
  final String title;
  final List<MediaItem> items;
  final Future<List<MediaItem>>? apiResponse;

  CategoryListItem({
    this.onlineService = OnlineService.none,
    required this.title,
    this.items = const [],
    this.apiResponse,
  });

  Future<List<MediaItem>> get itemsFuture async {
    if (apiResponse != null) {
      return await apiResponse!;
    }

    return items;
  }
}
