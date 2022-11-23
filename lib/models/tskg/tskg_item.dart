import 'package:freezed_annotation/freezed_annotation.dart';

part 'tskg_item.freezed.dart';
part 'tskg_item.g.dart';

@freezed
class TskgItem with _$TskgItem {
  const factory TskgItem({
    required String showId,
    
    required DateTime date,

    @Default([]) List<String> badges,

    @Default('') String title,

    @Default('') String subtitle,
    @Default('') String genres,
    @Default('') String link,

  }) = _TskgItem;

  factory TskgItem.fromJson(Map<String, Object?> json)
      => _$TskgItemFromJson(json);

  /// извлекаем идентификатор сериала из ссылки
  static String getShowIdFromLink(String link) {
    // разделяем url по '/'
    final path = link.split('/');
    
    if (link.startsWith('/show') && path.length > 1) {
      // ^ если url похож на ссылку сериала
      
      // идентификатор сериала должен быть третьим элементом в массиве
      return path.elementAt(2);

    } else {
      // ^ если url странный
      
      return '';
    }
  }
}

// @JsonSerializable()
// class TskgItem {
//   final String title;
//   final String subtitle;
//   final String genres;
//   final String link;
//   String showId;
  
//   TskgItem({
//     required this.date,
//     this.badges = const [],
//     this.title = '',
//     this.subtitle = '',
//     this.genres = '',
//     this.link = '',
//     this.showId = '',
//   }) {
//     /// разделяем url по '/'
//     final path = link.split('/');
    
//     if (link.startsWith('/show') && path.length > 1) {
//       /// ^ если url похож на ссылку сериала
      
//       /// идентификатор сериала должен быть третьим элементом в массиве
//       showId = path.elementAt(2);

//     } else {
//       /// ^ если url странный
      
//       showId = '';
//     }
//   }

//   factory TskgItem.fromJson(Map<String, dynamic> json) =>
//     _$TskgItemFromJson(json);

//   Map<String, dynamic> toJson() => _$TskgItemToJson(this);
// }