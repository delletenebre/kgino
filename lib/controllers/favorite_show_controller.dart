import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kgino/api/tskg/models/tskg_favorite_show.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';

class FavoriteShowController extends GetxController  {

  final favoriteShows = <TskgFavoriteShow>[].obs;

  @override
  void onInit() {
    super.onInit();

    GetStorage.init('FavoriteShows').then((value) {
      
    });
  }

  /// есть ли сериал в списке избранного
  bool isShowInFavorite(String showId) {
    final favoriteShow = favoriteShows.firstWhereOrNull((favoriteShow) {
      return favoriteShow.id == showId;
    });

    return favoriteShow != null;
  }

  /// добавить сериал в список избранного
  Future<void> addShowTofavorites(TskgShow show) async {

  }

  /// удалить сериал из списока избранного
  Future<void> removeShowFromfavorites(String showId) async {

  }

}