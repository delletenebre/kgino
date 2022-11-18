import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';
import 'ockg_file_meta.dart';

part 'ockg_file.freezed.dart';
part 'ockg_file.g.dart';

@freezed
class OckgFile with _$OckgFile {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgFile({
    @IntConverter()
    @Default(0) int fileId,
    
    @Default('') String name,

    @IntConverter()
    @Default(0) int size,

    @Default(false) bool isDir,
    
    required OckgFileMeta metainfo,
    
    @Default([]) List<String> frames,

    @Default('') String quality,

    @Default([]) List<String> translation,

    @Default('') String path,
    
    @Default(false) bool active,

    //@Default([]) List<String> smallFrames,

  }) = _OckgFile;

  factory OckgFile.fromJson(Map<String, Object?> json)
      => _$OckgFileFromJson(json);
}
