import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/request_state.dart';
import '../../models/tskg/tskg_favorite.dart';
import '../../models/tskg/tskg_show.dart';

class TskgFavoritesCubit extends Cubit<RequestState<List<TskgShow>>> {
  /// ключ для сохранённого значения
  static const _storageKey = 'tskg_favorites';

  /// хранилище данных
  late Box<TskgFavorite> _storage;

  TskgFavoritesCubit() : super(const RequestState.loading()) {
    /// регистрируем модель для избранных сериалов 
    if (!Hive.isAdapterRegistered(TskgFavoriteAdapter().typeId)) {
      Hive.registerAdapter(TskgFavoriteAdapter());
    }
    
    /// инициализируем хранилище
    Hive.openBox<TskgFavorite>(_storageKey).then((box) {
      _storage = box;
      
      _emitState();
    });
  }

  /// добавляем сериал в избранное
  void add(TskgShow show) {
    final episodeCount = show.seasons.fold(0, (previousValue, season) {
      return previousValue + season.episodes.length;
    });

    final favorite = TskgFavorite(
      showId: show.showId,
      name: show.name,
      episodeCount: episodeCount,
      createdAt: DateTime.now(),
    );
    
    /// сохраняем значение на диск
    _storage.put(show.showId, favorite);

    _emitState();
  }

  /// удаляем сериал из избранного
  void remove(String showId) {
    _storage.delete(showId);

    _emitState();
  }

  List<TskgFavorite> get sorted {
    final favorites = _storage.values.toList()
      ..sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });

    return favorites;
  }

  void _emitState() {
    if (!isClosed) {
      final shows = sorted.map((favoriteShow) {
        return TskgShow(
          showId: favoriteShow.showId,
          name: favoriteShow.name,
        );
      }).toList();
      
      emit(RequestState.success(shows));
    }
  }

  bool containsShow(String id) {
    if (state.isSuccess) {
      final items = state.data;
      final item = items.firstWhereOrNull((item) => item.showId == id);
      return item != null;
    }

    return false;
    
  }

}
