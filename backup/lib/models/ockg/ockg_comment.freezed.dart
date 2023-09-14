// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ockg_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OckgComment _$OckgCommentFromJson(Map<String, dynamic> json) {
  return _OckgComment.fromJson(json);
}

/// @nodoc
mixin _$OckgComment {
  @IntConverter()
  int get commentId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get toUserName => throw _privateConstructorUsedError;
  @IntConverter()
  int get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  @IntConverter()
  int get votes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OckgCommentCopyWith<OckgComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OckgCommentCopyWith<$Res> {
  factory $OckgCommentCopyWith(
          OckgComment value, $Res Function(OckgComment) then) =
      _$OckgCommentCopyWithImpl<$Res, OckgComment>;
  @useResult
  $Res call(
      {@IntConverter() int commentId,
      DateTime createdAt,
      String text,
      String toUserName,
      @IntConverter() int userId,
      String userName,
      @IntConverter() int votes});
}

/// @nodoc
class _$OckgCommentCopyWithImpl<$Res, $Val extends OckgComment>
    implements $OckgCommentCopyWith<$Res> {
  _$OckgCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? createdAt = null,
    Object? text = null,
    Object? toUserName = null,
    Object? userId = null,
    Object? userName = null,
    Object? votes = null,
  }) {
    return _then(_value.copyWith(
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      toUserName: null == toUserName
          ? _value.toUserName
          : toUserName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OckgCommentCopyWith<$Res>
    implements $OckgCommentCopyWith<$Res> {
  factory _$$_OckgCommentCopyWith(
          _$_OckgComment value, $Res Function(_$_OckgComment) then) =
      __$$_OckgCommentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntConverter() int commentId,
      DateTime createdAt,
      String text,
      String toUserName,
      @IntConverter() int userId,
      String userName,
      @IntConverter() int votes});
}

/// @nodoc
class __$$_OckgCommentCopyWithImpl<$Res>
    extends _$OckgCommentCopyWithImpl<$Res, _$_OckgComment>
    implements _$$_OckgCommentCopyWith<$Res> {
  __$$_OckgCommentCopyWithImpl(
      _$_OckgComment _value, $Res Function(_$_OckgComment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? createdAt = null,
    Object? text = null,
    Object? toUserName = null,
    Object? userId = null,
    Object? userName = null,
    Object? votes = null,
  }) {
    return _then(_$_OckgComment(
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      toUserName: null == toUserName
          ? _value.toUserName
          : toUserName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_OckgComment implements _OckgComment {
  const _$_OckgComment(
      {@IntConverter() this.commentId = 0,
      required this.createdAt,
      this.text = '',
      this.toUserName = '',
      @IntConverter() this.userId = 0,
      this.userName = '',
      @IntConverter() this.votes = 0});

  factory _$_OckgComment.fromJson(Map<String, dynamic> json) =>
      _$$_OckgCommentFromJson(json);

  @override
  @JsonKey()
  @IntConverter()
  final int commentId;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final String toUserName;
  @override
  @JsonKey()
  @IntConverter()
  final int userId;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  @IntConverter()
  final int votes;

  @override
  String toString() {
    return 'OckgComment(commentId: $commentId, createdAt: $createdAt, text: $text, toUserName: $toUserName, userId: $userId, userName: $userName, votes: $votes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OckgComment &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.toUserName, toUserName) ||
                other.toUserName == toUserName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.votes, votes) || other.votes == votes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, commentId, createdAt, text,
      toUserName, userId, userName, votes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OckgCommentCopyWith<_$_OckgComment> get copyWith =>
      __$$_OckgCommentCopyWithImpl<_$_OckgComment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OckgCommentToJson(
      this,
    );
  }
}

abstract class _OckgComment implements OckgComment {
  const factory _OckgComment(
      {@IntConverter() final int commentId,
      required final DateTime createdAt,
      final String text,
      final String toUserName,
      @IntConverter() final int userId,
      final String userName,
      @IntConverter() final int votes}) = _$_OckgComment;

  factory _OckgComment.fromJson(Map<String, dynamic> json) =
      _$_OckgComment.fromJson;

  @override
  @IntConverter()
  int get commentId;
  @override
  DateTime get createdAt;
  @override
  String get text;
  @override
  String get toUserName;
  @override
  @IntConverter()
  int get userId;
  @override
  String get userName;
  @override
  @IntConverter()
  int get votes;
  @override
  @JsonKey(ignore: true)
  _$$_OckgCommentCopyWith<_$_OckgComment> get copyWith =>
      throw _privateConstructorUsedError;
}
