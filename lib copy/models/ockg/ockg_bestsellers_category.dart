import 'package:freezed_annotation/freezed_annotation.dart';

import 'ockg_movie.dart';

part 'ockg_bestsellers_category.freezed.dart';
part 'ockg_bestsellers_category.g.dart';

@freezed
class OckgBestsellersCategory with _$OckgBestsellersCategory {
  const OckgBestsellersCategory._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgBestsellersCategory({
    required String categoryId,
    required String name,
    required List<OckgMovie> movies,
  }) = _OckgBestsellersCategory;

  factory OckgBestsellersCategory.fromJson(Map<String, Object?> json)
      => _$OckgBestsellersCategoryFromJson(json);

}
