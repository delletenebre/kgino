
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/tskg_api_provider.dart';
import '../../models/movie_item.dart';
import '../../models/request_state.dart';
import '../../models/tskg/tskg_show.dart';

export '../../models/request_state.dart';

class TskgNewsController extends Cubit<RequestState<List<TskgMovieItem>>> {

  final _api = GetIt.instance<TskgApiProvider>();

  TskgNewsController() : super(const RequestState.loading()) {
    _api.getNews().then((news) {
      if (!isClosed) {
        if (news.isEmpty) {
          /// ^ если данных нет
          emit(const RequestState.empty());
        } else {
          /// ^ если данные получены успешно
          emit(RequestState.success(news));
        }
      }
    });
    
  }

}
