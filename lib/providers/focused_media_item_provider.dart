import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/tmdb_api_provider.dart';
import '../models/media_item.dart';
import '../models/tmdb_item.dart';

part 'focused_media_item_provider.g.dart';

@riverpod
class FocusedMediaItem extends _$FocusedMediaItem {
  @override
  FutureOr<MediaItem?> build() async {
    // ref.onClose(() {
    //   debugPrint('navigationProvider disposed');
    // });

    return null;
  }

  Future<void> loadDetails(MediaItem? mediaItem) async {
    state = AsyncData(mediaItem);

    if (mediaItem != null) {
      state = const AsyncLoading();

      final tmdb = (await AsyncValue.guard(() async {
        /// запрашиваем данные на TMDB
        return await mediaItem.loadTmdb(ref);
      }))
          .valueOrNull;

      state = AsyncData(mediaItem.copyWith(tmdb: tmdb));
    }
  }

  void updateItem(MediaItem? mediaItem) {
    //if (mediaItem != null) {
    loadDetails(mediaItem);
    //}
    //state = AsyncData(mediaItem);
  }

  void reset() {
    state = const AsyncData(null);
  }

  bool get hasItem => state.valueOrNull != null;
}
