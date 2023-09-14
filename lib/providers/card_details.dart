import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/tmdb_api_provider.dart';
import '../models/media_item.dart';

part 'card_details.g.dart';

@riverpod
class CardDetails extends _$CardDetails {
  @override
  FutureOr<MediaItem?> build() async {
    // ref.onClose(() {
    //   debugPrint('navigationProvider disposed');
    // });

    return null;
  }

  Future<void> loadDetails(MediaItem? mediaItem) async {
    //final api = ref.read(tmdbApiProvider);

    /// отменяем выполнение запроса, если страница закрыта
    // final cancelToken = api.getCancelToken();
    // ref.onDispose(cancelToken.cancel);

    // state = await AsyncValue.guard(() async {
    //   /// отправляем запрос
    //   final response = await api.searchMovie(
    //     title: mediaItem?.title ?? '',
    //     year: '',
    //     cancelToken: cancelToken,
    //   );

    //   return response;
    // });
    state = AsyncData(mediaItem);
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
