import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'ockg_file_meta_media.freezed.dart';
part 'ockg_file_meta_media.g.dart';

@freezed
class OckgFileMetaMedia with _$OckgFileMetaMedia {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgFileMetaMedia({
    @Default('') String label,
    
    @Default('') String info,

  }) = _OckgFileMetaMedia;

  factory OckgFileMetaMedia.fromJson(Map<String, Object?> json)
      => _$OckgFileMetaMediaFromJson(json);
}
