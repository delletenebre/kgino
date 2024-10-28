import 'dart:async';

import 'package:flutter/foundation.dart';

import 'media_item.dart';

class CategoryListItem {
  final Key? key;
  final OnlineService onlineService;
  final String title;
  final List<MediaItem> items;
  final FutureOr<List<MediaItem>>? apiResponse;

  CategoryListItem({
    this.key,
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
