// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ockg_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OckgComment _$$_OckgCommentFromJson(Map<String, dynamic> json) =>
    _$_OckgComment(
      commentId: json['comment_id'] == null
          ? 0
          : const IntConverter().fromJson(json['comment_id']),
      createdAt: DateTime.parse(json['created_at'] as String),
      text: json['text'] as String? ?? '',
      toUserName: json['to_user_name'] as String? ?? '',
      userId: json['user_id'] == null
          ? 0
          : const IntConverter().fromJson(json['user_id']),
      userName: json['user_name'] as String? ?? '',
      votes: json['votes'] == null
          ? 0
          : const IntConverter().fromJson(json['votes']),
    );

Map<String, dynamic> _$$_OckgCommentToJson(_$_OckgComment instance) =>
    <String, dynamic>{
      'comment_id': const IntConverter().toJson(instance.commentId),
      'created_at': instance.createdAt.toIso8601String(),
      'text': instance.text,
      'to_user_name': instance.toUserName,
      'user_id': const IntConverter().toJson(instance.userId),
      'user_name': instance.userName,
      'votes': const IntConverter().toJson(instance.votes),
    };
