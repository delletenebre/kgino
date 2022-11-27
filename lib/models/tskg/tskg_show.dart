import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:palette_generator/palette_generator.dart';

import 'tskg_season.dart';

part 'tskg_show.freezed.dart';
part 'tskg_show.g.dart';

@freezed
class TskgShow with _$TskgShow {
  const TskgShow._();

  const factory TskgShow({
    @Default('') String showId,
    
    DateTime? date,

    @Default([]) List<String> badges,

    @Default('') String title,

    @Default('') String subtitle,
    @Default([]) List<String> genres,
    @Default('') String link,

    @Default('') String originalTitle,
    @Default('') String years,
    @Default([]) List<String> countries,
    @Default('') String description,
    @Default([]) List<TskgSeason> seasons,

  }) = _TskgShow;

  factory TskgShow.fromJson(Map<String, Object?> json)
      => _$TskgShowFromJson(json);

  String get posterUrl => 'https://www.ts.kg/posters/$showId.png';

  Future<PaletteGenerator> getPaletteGenerator() async {
    return PaletteGenerator.fromImageProvider(
      NetworkImage(posterUrl)
    );
  }

  /// извлекаем идентификатор сериала из ссылки
  static String getShowIdFromLink(String link) {
    // разделяем url по '/'
    final path = link.split('/');
    
    if (link.startsWith('/show') && path.length > 1) {
      /// ^ если url похож на ссылку сериала
      
      /// идентификатор сериала должен быть третьим элементом в массиве
      return path.elementAt(2);

    } else {
      /// ^ если url странный
      
      return '';
    }
  }
}
