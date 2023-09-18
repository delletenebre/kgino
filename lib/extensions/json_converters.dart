import 'package:json_annotation/json_annotation.dart';

class StringConverter implements JsonConverter<String, dynamic> {
  const StringConverter();

  @override
  String fromJson(dynamic json) => json.toString();

  @override
  dynamic toJson(String object) => object;
}

class DoubleConverter implements JsonConverter<double, dynamic> {
  const DoubleConverter();

  @override
  double fromJson(dynamic json) => double.tryParse(json.toString()) ?? 0.0;

  @override
  double toJson(double object) => object;
}

class IntConverter implements JsonConverter<int, dynamic> {
  const IntConverter();

  @override
  int fromJson(dynamic json) => int.tryParse(json.toString()) ?? 0;

  @override
  int toJson(int object) => object;
}

class HtmlRemoveConverter implements JsonConverter<String, String> {
  const HtmlRemoveConverter();

  @override
  String fromJson(String json) => json
      .replaceAll('<br>', '\n')
      .replaceAll('<br />', '\n')
      .replaceAll('  ', ' ');

  @override
  String toJson(String object) => object;
}

/// поле translation у [OckgMovie] может быть как списком, так и сериализованой
/// переменной PHP a:1:{i:0;s:29:\"Профессиональный многоголосый\";}
class TranslationConverter implements JsonConverter<List<String>, dynamic> {
  const TranslationConverter();

  @override
  List<String> fromJson(dynamic json) {
    if (json is List) {
      return (json).map((e) => e as String).toList();
    } else {
      final tempString = json.toString();
      final firstQuoteIndex = tempString.indexOf('"');
      final secondQuoteIndex = tempString.indexOf('"', firstQuoteIndex);
      return [tempString.substring(firstQuoteIndex, secondQuoteIndex)];
    }
  }

  @override
  List<String> toJson(List<String> object) => object;
}
