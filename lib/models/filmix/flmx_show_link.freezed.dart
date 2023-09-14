// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flmx_show_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FlmxShowLink _$FlmxShowLinkFromJson(Map<String, dynamic> json) {
  return _FlmxShowLink.fromJson(json);
}

/// @nodoc
mixin _$FlmxShowLink {
  String get link => throw _privateConstructorUsedError;
  List<int> get qualities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlmxShowLinkCopyWith<FlmxShowLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlmxShowLinkCopyWith<$Res> {
  factory $FlmxShowLinkCopyWith(
          FlmxShowLink value, $Res Function(FlmxShowLink) then) =
      _$FlmxShowLinkCopyWithImpl<$Res, FlmxShowLink>;
  @useResult
  $Res call({String link, List<int> qualities});
}

/// @nodoc
class _$FlmxShowLinkCopyWithImpl<$Res, $Val extends FlmxShowLink>
    implements $FlmxShowLinkCopyWith<$Res> {
  _$FlmxShowLinkCopyWithImpl(this._value, this._then);

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
abstract class _$$_FlmxShowLinkCopyWith<$Res>
    implements $FlmxShowLinkCopyWith<$Res> {
  factory _$$_FlmxShowLinkCopyWith(
          _$_FlmxShowLink value, $Res Function(_$_FlmxShowLink) then) =
      __$$_FlmxShowLinkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link, List<int> qualities});
}

/// @nodoc
class __$$_FlmxShowLinkCopyWithImpl<$Res>
    extends _$FlmxShowLinkCopyWithImpl<$Res, _$_FlmxShowLink>
    implements _$$_FlmxShowLinkCopyWith<$Res> {
  __$$_FlmxShowLinkCopyWithImpl(
      _$_FlmxShowLink _value, $Res Function(_$_FlmxShowLink) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? qualities = null,
  }) {
    return _then(_$_FlmxShowLink(
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
class _$_FlmxShowLink implements _FlmxShowLink {
  const _$_FlmxShowLink({this.link = '', final List<int> qualities = const []})
      : _qualities = qualities;

  factory _$_FlmxShowLink.fromJson(Map<String, dynamic> json) =>
      _$$_FlmxShowLinkFromJson(json);

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
    return 'FlmxShowLink(link: $link, qualities: $qualities)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlmxShowLink &&
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
  _$$_FlmxShowLinkCopyWith<_$_FlmxShowLink> get copyWith =>
      __$$_FlmxShowLinkCopyWithImpl<_$_FlmxShowLink>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FlmxShowLinkToJson(
      this,
    );
  }
}

abstract class _FlmxShowLink implements FlmxShowLink {
  const factory _FlmxShowLink({final String link, final List<int> qualities}) =
      _$_FlmxShowLink;

  factory _FlmxShowLink.fromJson(Map<String, dynamic> json) =
      _$_FlmxShowLink.fromJson;

  @override
  String get link;
  @override
  List<int> get qualities;
  @override
  @JsonKey(ignore: true)
  _$$_FlmxShowLinkCopyWith<_$_FlmxShowLink> get copyWith =>
      throw _privateConstructorUsedError;
}
