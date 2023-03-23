import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'ockg_trailer.freezed.dart';
part 'ockg_trailer.g.dart';

@freezed
class OckgTrailer with _$OckgTrailer {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgTrailer({
    @IntConverter() @Default(0) int width,
    @IntConverter() @Default(0) int height,
    
    @Default('') String name,
    @Default('') String preview,
    @Default('') String video,

  }) = _OckgTrailer;

  factory OckgTrailer.fromJson(Map<String, Object?> json)
      => _$OckgTrailerFromJson(json);
}
