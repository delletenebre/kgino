import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:palette_generator/palette_generator.dart';

import 'tskg_season.dart';

part 'tskg_show.freezed.dart';

@freezed
class TskgShow with _$TskgShow {
  const TskgShow._();

  const factory TskgShow({
    @Default('') String showId,
    @Default('') String name,

    /// для последних добавленных
    DateTime? date,

    @Default([]) List<String> badges,
    @Default('') String subtitle,
    @Default([]) List<String> genres,
    @Default('') String originalTitle,
    @Default('') String years,
    @Default([]) List<String> countries,
    @Default('') String description,
    @Default([]) List<TskgSeason> seasons,

    /// озвучка
    @Default('') String voiceActing,

    /// другие озвучки
    @Default([]) List<TskgShow> voiceActings,

  }) = _TskgShow;


  String get posterUrl => 'https://www.ts.kg/posters/$showId.png';

  Future<PaletteGenerator> getPaletteGenerator() async {
    return PaletteGenerator.fromImageProvider(
      NetworkImage(posterUrl)
    );
  }

  /// извлекаем идентификатор сериала из ссылки
  static String getShowIdFromUrl(String url) {
    // разделяем url по '/'
    final path = url.split('/');
    
    if (url.startsWith('/show') && path.length > 1) {
      /// ^ если url похож на ссылку сериала
      
      /// идентификатор сериала должен быть третьим элементом в списке
      return path.elementAt(2);

    } else {
      /// ^ если url странный
      
      return '';
    }
  }
}
