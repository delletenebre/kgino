import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../api/tmdb_api_provider.dart';
import 'tmdb_item.dart';

part 'item.freezed.dart';
part 'item.g.dart';

abstract class Tmdb {
  int get population;
  String get name;
}

abstract class Details {
  Future<Item> getDetails(String id);
}

@freezed
class Item with _$Item {
  const Item._();

  factory Item({
    @Default('') String id,
    @Default('') String title,
    @Default('') String originalTitle,
    @Default('') String overview,
    String? posterImage,
    @Default([]) List<String> genres,
    @Default('') String year,
    @Default([]) List<String> countries,
    TmdbItem? tmdb,
  }) = _Item;

  factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}

@freezed
class FilmixItem with _$FilmixItem {
  const FilmixItem._();

  @With<Tmdb>()
  factory FilmixItem() = _FilmixItem;

  factory FilmixItem.fromJson(Map<String, Object?> json) =>
      _$FilmixItemFromJson(json);
}
