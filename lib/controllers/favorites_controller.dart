import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kgino/api/tskg/models/tskg_favorite_show.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';

class FavoritesController extends GetxController  {
  /// хранилище данных
  final storage = GetStorage('favorites');

  /// список избранных сериалов
  final favorites = <String, TskgFavoriteShow>{}.obs;

  @override
  void onInit() {
    super.onInit();

    storage.initStorage.then((initialized) {
      /// считываем с диска сохранённые в избранном сериалы
      final keys = storage.getKeys();
      for (final key in keys) {
        favorites.putIfAbsent(
          key,
          () => TskgFavoriteShow.fromJson(storage.read(key))
        );
      }

      /// обновляем UI
      favorites.refresh();
    });
    
  }

  /// есть ли сериал в списке избранного
  bool isShowInFavorite(String showId) {
    return favorites.containsKey(showId);
  }

  /// добавить сериал в список избранного
  Future<void> addShowToFavorites(TskgShow show) async {
    favorites.putIfAbsent(show.id, () {
      return TskgFavoriteShow(show.id, show.title, show.episodesCount);
    });

    /// обновляем UI
    favorites.refresh();

    /// сохраняем изменения на диск
    _saveInStorage();
  }

  /// удалить сериал из списока избранного
  Future<void> removeShowFromFavorites(String showId) async {
    favorites.remove(showId);

    /// обновляем UI
    favorites.refresh();

    /// сохраняем изменения на диск
    _saveInStorage();
  }

  /// сохранить список избранного на диск
  Future<void> _saveInStorage() async {
    await storage.erase();

    favorites.forEach((key, value) async {
      await storage.write(key, value.toJson());
    });
  }

}