import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../models/ockg/ockg_bestsellers_category.dart';
import '../../models/request_state.dart';

export '../../models/request_state.dart';

class OckgBestsellersController extends Cubit<RequestState<List<OckgBestsellersCategory>>> {

  final _api = GetIt.instance<OckgApiProvider>();

  OckgBestsellersController() : super(const RequestState.loading()) {
    _api.getBestsellers().then((bestsellers) {
      if (!isClosed) {
        if (bestsellers.isEmpty) {
          /// ^ если данных нет
          emit(const RequestState.empty());
        } else {
          /// ^ если данные получены успешно
          emit(RequestState.success(bestsellers));
        }
      }
    });
    
  }

  @override
  Future<void> onChange(Change<RequestState<List<OckgBestsellersCategory>>> change) async {
    super.onChange(change);

  }
}
