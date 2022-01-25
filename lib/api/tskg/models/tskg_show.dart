
import 'package:json_annotation/json_annotation.dart';
import 'package:kgino/api/tskg/models/tskg_season.dart';

part 'tskg_show.g.dart';

@JsonSerializable()
class TskgShow {
  final String id;
  final String title;
  final String originalTitle;
  final String years;
  final List<String> genres;
  final List<Country> countries;
  final String description;
  final List<TskgSeason> seasons;
  
  TskgShow({
    this.id = '',
    this.title = '',
    this.originalTitle = '',
    this.years = '',
    this.genres = const [],
    this.countries = const [],
    this.description = '',
    this.seasons = const [],
    
  });

  factory TskgShow.fromJson(Map<String, dynamic> json) =>
    _$TskgShowFromJson(json);

  Map<String, dynamic> toJson() => _$TskgShowToJson(this);
}

@JsonSerializable()
class Country {
  final String name;
  final String imageUrl;
  
  Country({
    this.name = '',
    this.imageUrl = '',
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
    _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
