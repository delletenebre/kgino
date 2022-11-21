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

  int getGenreId() {
    switch (name) {
      case 'Боевики':
        return 6;
      case 'Фантастика/фэнтези':
        return 34;
      case 'Комедии':
        return 4;
      case 'Драма/мелодрама':
        return 2;
      case 'Сериалы':
        return 33;
      case 'Мультфильмы':
        return 13;
      case 'Ужасы':
        return 7;
      case 'Документальные':
        return 23;
      case 'Аниме':
        return 25;
      case 'Детектив':
        return 32;
      default:
        return 1;
    }
  }
}