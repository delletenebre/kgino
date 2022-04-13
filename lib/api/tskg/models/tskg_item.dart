
import 'package:json_annotation/json_annotation.dart';
import 'package:kgino/api/tskg/tskg_api.dart';

part 'tskg_item.g.dart';

@JsonSerializable()
class TskgItem {
  final DateTime date;
  final List<String> badges;
  final String title;
  final String subtitle;
  final String genres;
  final String link;
  String showId;
  
  TskgItem({
    required this.date,
    this.badges = const [],
    this.title = '',
    this.subtitle = '',
    this.genres = '',
    this.link = '',
    this.showId = '',
  }) {
    /// разделяем url по '/'
    final path = link.split('/');
    
    if (link.startsWith('/show') && path.length > 1) {
      /// ^ если url похож на ссылку сериала
      
      /// идентификатор сериала должен быть третьим элементом в массиве
      showId = path.elementAt(2);

    } else {
      /// ^ если url странный
      
      showId = '';
    }
  }

  factory TskgItem.fromJson(Map<String, dynamic> json) =>
    _$TskgItemFromJson(json);

  Map<String, dynamic> toJson() => _$TskgItemToJson(this);
}