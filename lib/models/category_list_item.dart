import 'api_response.dart';
import 'kgino_item.dart';

class CategoryListItem {
  final String title;
  final List<KginoItem> items;
  final Future<ApiResponse<List<KginoItem>>>? apiResponse;

  CategoryListItem({
    required this.title,
    this.items = const [],
    this.apiResponse,
  });

  Future<List<KginoItem>> get itemsFuture async {
    return Future.microtask(() async {
      if (apiResponse != null) {
        final response = await apiResponse!;

        if (response.isSuccess) {
          return response.asData.data;
        }
      }

      return items;
    });
  }
}
