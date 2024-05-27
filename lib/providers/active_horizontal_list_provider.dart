import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_horizontal_list_provider.g.dart';

/// контроллер активного горизонтального списка
@riverpod
class ActiveHorizontalList extends _$ActiveHorizontalList {
  @override
  int build() {
    return 0;
  }

  void updateIndex(int index) async {
    if (state != index) {
      state = index;
    }
  }

  void onMoveLeft() {
    state = -1;
  }
}
