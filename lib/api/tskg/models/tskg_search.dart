
import 'package:json_annotation/json_annotation.dart';

part 'tskg_search.g.dart';

@JsonSerializable()
class TskgSearch {
  final String name;
  final String url;
  
  TskgSearch({
    this.name = '',
    this.url = '',
  });

  factory TskgSearch.fromJson(Map<String, dynamic> json) =>
    _$TskgSearchFromJson(json);

  Map<String, dynamic> toJson() => _$TskgSearchToJson(this);
}
