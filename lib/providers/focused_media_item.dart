// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../models/media_item.dart';
// import 'storage_provider.dart';

// part 'focused_media_item.g.dart';

// @riverpod
// class FocusedMediaItem extends _$FocusedMediaItem {
//   @override
//   Future<MediaItem?> build(MediaItem? mediaItem) async {
//     return fetch();
//   }

//   Future<MediaItem?> fetch() async {
//     final storage = ref.read(storageProvider);

//     if (mediaItem == null) {
//       return null;
//     }

//     /// если есть, то находим сохранённую в базе данных информацию
//     final savedItem = mediaItem!.findSaved(storage);

//     /// загружаем информацию о сериале или фильме
//     final item = await savedItem.loadDetails(ref);

//     /// загружаем сезоны
//     final seasons = await item.loadSeasons(ref);

//     /// объединяем информацию с сезонами
//     item.seasons = seasons;

//     /// загружаем варианты озвучки
//     final voices = await item.loadVoices(ref);

//     /// объединяем информацию с вариантами озвучки
//     item.voices = voices;

//     return item;
//   }

//   bool get hasItem => state.valueOrNull != null;
// }
