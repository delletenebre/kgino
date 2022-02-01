import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/models/favorite_model.dart';

class FavoritesController extends GetxController  {
  /// хранилище данных
  static const storageName = 'favorites';

  /// список избранных сериалов
  final _items = Hive.box<FavoriteModel>(storageName).obs;

  Box<FavoriteModel> get items => _items.value;

  /// есть ли сериал в списке избранного
  bool isShowInFavorite(String showId) {
    return _items.value.containsKey(showId);
  }

  /// добавить сериал в список избранного
  Future<void> addShowToFavorites(TskgShow show) async {
    final item = FavoriteModel(show.id, show.title, show.episodesCount);
    
    _items.value.put(show.id, item);

    _items.refresh();
  }

  /// удалить сериал из списока избранного
  Future<void> removeShowFromFavorites(String showId) async {
    _items.value.delete(showId);

    _items.refresh();
  }

}