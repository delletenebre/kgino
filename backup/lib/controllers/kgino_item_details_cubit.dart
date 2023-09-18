import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../models/api_response.dart';
import '../models/kgino_item.dart';
import '../resources/krs_storage.dart';


class KginoItemDetailsCubit extends Cubit<ApiResponse<KginoItem>> {

  /// идентификатор контроля выполнения запросов
  CancelToken? _cancelToken;
  CancelToken? get cancelToken => _cancelToken;
  
  /// хранилище данных
  final _storage = GetIt.instance<KrsStorage>();

  KginoItemDetailsCubit() : super(ApiResponse.empty());

  /// обновляем идентификатор контроля выполнения запросов
  void updateCancelToken() {
    /// завершаем выполнение предыдущего запроса
    _cancelToken?.cancel();

    _cancelToken = CancelToken();
  }

  Future<void> fetch(Future<ApiResponse<KginoItem>> request) async {
    if (!isClosed) {
      emit(ApiResponse.loading());

      final response = await request;

      if (!isClosed) {

        if (response.isSuccess) {
          final kginoItem = response.asData.data;
          final dbItem = kginoItem.isarId != null 
            ? (await _storage.db.kginoItems.get(kginoItem.isarId!) ?? kginoItem)
            : kginoItem;

          kginoItem.subtitlesEnabled = dbItem.subtitlesEnabled;
          kginoItem.bookmarked = dbItem.bookmarked;
          kginoItem.seenEpisodes = dbItem.seenEpisodes;
          kginoItem.voiceActing = dbItem.voiceActing;
          kginoItem.playableQuality = dbItem.playableQuality;
          if (kginoItem.voiceActings.containsKey(dbItem.voiceActing)) {
            kginoItem.seasons = kginoItem.voiceActings[dbItem.voiceActing]!.seasons;
          }
          
          emit(ApiResponse.data(kginoItem));
        
        } else {
          emit(response);
        }

      }
    }
    
  }

}