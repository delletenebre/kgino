// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tskg_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TskgShow _$TskgShowFromJson(Map<String, dynamic> json) => TskgShow(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      originalTitle: json['originalTitle'] as String? ?? '',
      years: json['years'] as String? ?? '',
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$TskgShowToJson(TskgShow instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'originalTitle': instance.originalTitle,
      'years': instance.years,
      'genres': instance.genres,
      'countries': instance.countries,
      'description': instance.description,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
