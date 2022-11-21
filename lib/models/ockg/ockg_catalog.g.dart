// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgCatalog _$$_OckgCatalogFromJson(Map<String, dynamic> json) =>
    _$_OckgCatalog(
      total: json['total'] == null
          ? 0
          : const IntConverter().fromJson(json['total']),
      offset: json['offset'] == null
          ? 0
          : const IntConverter().fromJson(json['offset']),
      pagesize: json['pagesize'] == null
          ? 0
          : const IntConverter().fromJson(json['pagesize']),
      movies: (json['movies'] as List<dynamic>?)
              ?.map((e) => OckgMovie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_OckgCatalogToJson(_$_OckgCatalog instance) =>
    <String, dynamic>{
      'total': const IntConverter().toJson(instance.total),
      'offset': const IntConverter().toJson(instance.offset),
      'pagesize': const IntConverter().toJson(instance.pagesize),
      'movies': instance.movies,
    };
