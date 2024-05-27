// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filmix_show_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilmixShowLink _$FilmixShowLinkFromJson(Map<String, dynamic> json) {
  return _FilmixShowLink.fromJson(json);
}

/// @nodoc
mixin _$FilmixShowLink {
  String get link => throw _privateConstructorUsedError;
  List<int> get qualities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilmixShowLinkCopyWith<FilmixShowLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixShowLinkCopyWith<$Res> {
  factory $FilmixShowLinkCopyWith(
          FilmixShowLink value, $Res Function(FilmixShowLink) then) =
      _$FilmixShowLinkCopyWithImpl<$Res, FilmixShowLink>;
  @useResult
  $Res call({String link, List<int> qualities});
}

/// @nodoc
class _$FilmixShowLinkCopyWithImpl<$Res, $Val extends FilmixShowLink>
    implements $FilmixShowLinkCopyWith<$Res> {
  _$FilmixShowLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? qualities = null,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      qualities: null == qualities
          ? _value.qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilmixShowLinkImplCopyWith<$Res>
    implements $FilmixShowLinkCopyWith<$Res> {
  factory _$$FilmixShowLinkImplCopyWith(_$FilmixShowLinkImpl value,
          $Res Function(_$FilmixShowLinkImpl) then) =
      __$$FilmixShowLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link, List<int> qualities});
}

/// @nodoc
class __$$FilmixShowLinkImplCopyWithImpl<$Res>
    extends _$FilmixShowLinkCopyWithImpl<$Res, _$FilmixShowLinkImpl>
    implements _$$FilmixShowLinkImplCopyWith<$Res> {
  __$$FilmixShowLinkImplCopyWithImpl(
      _$FilmixShowLinkImpl _value, $Res Function(_$FilmixShowLinkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? qualities = null,
  }) {
    return _then(_$FilmixShowLinkImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      qualities: null == qualities
          ? _value._qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilmixShowLinkImpl implements _FilmixShowLink {
  const _$FilmixShowLinkImpl(
      {this.link = '', final List<int> qualities = const []})
      : _qualities = qualities;

  factory _$FilmixShowLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilmixShowLinkImplFromJson(json);

  @override
  @JsonKey()
  final String link;
  final List<int> _qualities;
  @override
  @JsonKey()
  List<int> get qualities {
    if (_qualities is EqualUnmodifiableListView) return _qualities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualities);
  }

  @override
  String toString() {
    return 'FilmixShowLink(link: $link, qualities: $qualities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilmixShowLinkImpl &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality()
                .equals(other._qualities, _qualities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, link, const DeepCollectionEquality().hash(_qualities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilmixShowLinkImplCopyWith<_$FilmixShowLinkImpl> get copyWith =>
      __$$FilmixShowLinkImplCopyWithImpl<_$FilmixShowLinkImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilmixShowLinkImplToJson(
      this,
    );
  }
}

abstract class _FilmixShowLink implements FilmixShowLink {
  const factory _FilmixShowLink(
      {final String link, final List<int> qualities}) = _$FilmixShowLinkImpl;

  factory _FilmixShowLink.fromJson(Map<String, dynamic> json) =
      _$FilmixShowLinkImpl.fromJson;

  @override
  String get link;
  @override
  List<int> get qualities;
  @override
  @JsonKey(ignore: true)
  _$$FilmixShowLinkImplCopyWith<_$FilmixShowLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
