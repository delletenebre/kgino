
import 'package:json_annotation/json_annotation.dart';
import 'package:kgino/api/tskg/tskg.dart';

part 'tskg_item.g.dart';

@JsonSerializable()
class TskgItem {
  final DateTime date;
  final List<TskgBagdeType> badges;
  final String title;
  final String subtitle;
  final String genres;
  final String link;
  String tvshowId;
  
  TskgItem({
    required this.date,
    this.badges = const [],
    this.title = '',
    this.subtitle = '',
    this.genres = '',
    this.link = '',
    this.tvshowId = '',
  }) {
    /// разделяем url по '/'
    final path = link.split('/');
    
    if (link.startsWith('/show') && path.length > 1) {
      /// ^ если url похож на ссылку сериала
      
      /// идентификатор сериала должен быть третьим элементом в массиве
      tvshowId = path.elementAt(2);

    } else {
      /// ^ если url странный
      
      tvshowId = '';
    }
  }

  /// cсылка на постер сериала
  String get poster => 'https://www.ts.kg/posters/$tvshowId.png';

  /// cсылка на постер сериала
  String get tvshowUrl => 'https://www.ts.kg/show/$tvshowId.png';

  factory TskgItem.fromJson(Map<String, dynamic> json) =>
    _$TskgItemFromJson(json);

  Map<String, dynamic> toJson() => _$TskgItemToJson(this);
}