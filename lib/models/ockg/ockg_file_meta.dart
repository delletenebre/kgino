import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';
import 'ockg_file_meta_media.dart';

part 'ockg_file_meta.freezed.dart';
part 'ockg_file_meta.g.dart';

@freezed
class OckgFileMeta with _$OckgFileMeta {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgFileMeta({
    @IntConverter()
    @Default(0) int playtimeSeconds,
    
    @Default('') String format,

    required OckgFileMetaMedia video,
    required OckgFileMetaMedia audio,

  }) = _OckgFileMeta;

  factory OckgFileMeta.fromJson(Map<String, Object?> json)
      => _$OckgFileMetaFromJson(json);
}
