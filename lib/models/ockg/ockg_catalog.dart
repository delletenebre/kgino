import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';
import 'ockg_movie.dart';

part 'ockg_catalog.freezed.dart';
part 'ockg_catalog.g.dart';

@freezed
class OckgCatalog with _$OckgCatalog {
  const OckgCatalog._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgCatalog({
    @IntConverter() @Default(0) int total,
    @IntConverter() @Default(0) int offset,
    @IntConverter() @Default(0) int pagesize,
    
    @Default([]) List<OckgMovie> movies,

  }) = _OckgCatalog;

  factory OckgCatalog.fromJson(Map<String, Object?> json)
      => _$OckgCatalogFromJson(json);

  bool isLastPage(int currentItemsCount) {
    return ((total - pagesize - currentItemsCount) > 0);
  }
}
