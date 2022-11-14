// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_bestsellers_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgBestsellersCategory _$$_OckgBestsellersCategoryFromJson(
        Map<String, dynamic> json) =>
    _$_OckgBestsellersCategory(
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      movies: (json['movies'] as List<dynamic>)
          .map((e) => OckgMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_OckgBestsellersCategoryToJson(
        _$_OckgBestsellersCategory instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'movies': instance.movies,
    };
