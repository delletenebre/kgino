import 'package:freezed_annotation/freezed_annotation.dart';

part 'flmx_show_link.freezed.dart';
part 'flmx_show_link.g.dart';

@freezed
class FlmxShowLink with _$FlmxShowLink {
  const factory FlmxShowLink({
    @Default('') String link,
    @Default([]) List<int> qualities,
  }) = _FlmxShowLink;

  factory FlmxShowLink.fromJson(Map<String, Object?> json)
      => _$FlmxShowLinkFromJson(json);
}
