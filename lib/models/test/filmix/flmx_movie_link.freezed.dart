// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flmx_movie_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FlmxMovieLink _$FlmxMovieLinkFromJson(Map<String, dynamic> json) {
  return _FlmxMovieLink.fromJson(json);
}

/// @nodoc
mixin _$FlmxMovieLink {
  String get link => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlmxMovieLinkCopyWith<FlmxMovieLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlmxMovieLinkCopyWith<$Res> {
  factory $FlmxMovieLinkCopyWith(
          FlmxMovieLink value, $Res Function(FlmxMovieLink) then) =
      _$FlmxMovieLinkCopyWithImpl<$Res, FlmxMovieLink>;
  @useResult
  $Res call({String link, String translation});
}

/// @nodoc
class _$FlmxMovieLinkCopyWithImpl<$Res, $Val extends FlmxMovieLink>
    implements $FlmxMovieLinkCopyWith<$Res> {
  _$FlmxMovieLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? translation = null,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FlmxMovieLinkCopyWith<$Res>
    implements $FlmxMovieLinkCopyWith<$Res> {
  factory _$$_FlmxMovieLinkCopyWith(
          _$_FlmxMovieLink value, $Res Function(_$_FlmxMovieLink) then) =
      __$$_FlmxMovieLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link, String translation});
}

/// @nodoc
class __$$_FlmxMovieLinkCopyWithImpl<$Res>
    extends _$FlmxMovieLinkCopyWithImpl<$Res, _$_FlmxMovieLink>
    implements _$$_FlmxMovieLinkCopyWith<$Res> {
  __$$_FlmxMovieLinkCopyWithImpl(
      _$_FlmxMovieLink _value, $Res Function(_$_FlmxMovieLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? translation = null,
  }) {
    return _then(_$_FlmxMovieLink(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FlmxMovieLink implements _FlmxMovieLink {
  const _$_FlmxMovieLink({this.link = '', this.translation = ''});

  factory _$_FlmxMovieLink.fromJson(Map<String, dynamic> json) =>
      _$$_FlmxMovieLinkFromJson(json);

  @override
  @JsonKey()
  final String link;
  @override
  @JsonKey()
  final String translation;

  @override
  String toString() {
    return 'FlmxMovieLink(link: $link, translation: $translation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlmxMovieLink &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, link, translation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlmxMovieLinkCopyWith<_$_FlmxMovieLink> get copyWith =>
      __$$_FlmxMovieLinkCopyWithImpl<_$_FlmxMovieLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FlmxMovieLinkToJson(
      this,
    );
  }
}

abstract class _FlmxMovieLink implements FlmxMovieLink {
  const factory _FlmxMovieLink({final String link, final String translation}) =
      _$_FlmxMovieLink;

  factory _FlmxMovieLink.fromJson(Map<String, dynamic> json) =
      _$_FlmxMovieLink.fromJson;

  @override
  String get link;
  @override
  String get translation;
  @override
  @JsonKey(ignore: true)
  _$$_FlmxMovieLinkCopyWith<_$_FlmxMovieLink> get copyWith =>
      throw _privateConstructorUsedError;
}
