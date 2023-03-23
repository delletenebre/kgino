import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'ockg_comment.freezed.dart';
part 'ockg_comment.g.dart';

@freezed
class OckgComment with _$OckgComment {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OckgComment({
    @IntConverter() @Default(0) int commentId,
    required DateTime createdAt,

    @Default('') String text,
    @Default('') String toUserName,
    
    @IntConverter() @Default(0) int userId,
    @Default('') String userName,

    @IntConverter() @Default(0) int votes,

  }) = _OckgComment;

  factory OckgComment.fromJson(Map<String, Object?> json)
      => _$OckgCommentFromJson(json);
}
