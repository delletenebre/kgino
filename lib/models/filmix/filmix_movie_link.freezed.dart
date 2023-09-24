// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filmix_movie_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilmixMovieLink _$FilmixMovieLinkFromJson(Map<String, dynamic> json) {
  return _FilmixMovieLink.fromJson(json);
}

/// @nodoc
mixin _$FilmixMovieLink {
  String get link => throw _privateConstructorUsedError;
  String get translation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilmixMovieLinkCopyWith<FilmixMovieLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixMovieLinkCopyWith<$Res> {
  factory $FilmixMovieLinkCopyWith(
          FilmixMovieLink value, $Res Function(FilmixMovieLink) then) =
      _$FilmixMovieLinkCopyWithImpl<$Res, FilmixMovieLink>;
  @useResult
  $Res call({String link, String translation});
}

/// @nodoc
class _$FilmixMovieLinkCopyWithImpl<$Res, $Val extends FilmixMovieLink>
    implements $FilmixMovieLinkCopyWith<$Res> {
  _$FilmixMovieLinkCopyWithImpl(this._value, this._then);

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
abstract class _$$_FilmixMovieLinkCopyWith<$Res>
    implements $FilmixMovieLinkCopyWith<$Res> {
  factory _$$_FilmixMovieLinkCopyWith(
          _$_FilmixMovieLink value, $Res Function(_$_FilmixMovieLink) then) =
      __$$_FilmixMovieLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link, String translation});
}

/// @nodoc
class __$$_FilmixMovieLinkCopyWithImpl<$Res>
    extends _$FilmixMovieLinkCopyWithImpl<$Res, _$_FilmixMovieLink>
    implements _$$_FilmixMovieLinkCopyWith<$Res> {
  __$$_FilmixMovieLinkCopyWithImpl(
      _$_FilmixMovieLink _value, $Res Function(_$_FilmixMovieLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? translation = null,
  }) {
    return _then(_$_FilmixMovieLink(
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
class _$_FilmixMovieLink implements _FilmixMovieLink {
  const _$_FilmixMovieLink({this.link = '', this.translation = ''});

  factory _$_FilmixMovieLink.fromJson(Map<String, dynamic> json) =>
      _$$_FilmixMovieLinkFromJson(json);

  @override
  @JsonKey()
  final String link;
  @override
  @JsonKey()
  final String translation;

  @override
  String toString() {
    return 'FilmixMovieLink(link: $link, translation: $translation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilmixMovieLink &&
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
  _$$_FilmixMovieLinkCopyWith<_$_FilmixMovieLink> get copyWith =>
      __$$_FilmixMovieLinkCopyWithImpl<_$_FilmixMovieLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilmixMovieLinkToJson(
      this,
    );
  }
}

abstract class _FilmixMovieLink implements FilmixMovieLink {
  const factory _FilmixMovieLink(
      {final String link, final String translation}) = _$_FilmixMovieLink;

  factory _FilmixMovieLink.fromJson(Map<String, dynamic> json) =
      _$_FilmixMovieLink.fromJson;

  @override
  String get link;
  @override
  String get translation;
  @override
  @JsonKey(ignore: true)
  _$$_FilmixMovieLinkCopyWith<_$_FilmixMovieLink> get copyWith =>
      throw _privateConstructorUsedError;
}
