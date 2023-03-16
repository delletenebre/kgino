// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeviceDetails {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get vendor => throw _privateConstructorUsedError;
  String get osVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceDetailsCopyWith<DeviceDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceDetailsCopyWith<$Res> {
  factory $DeviceDetailsCopyWith(
          DeviceDetails value, $Res Function(DeviceDetails) then) =
      _$DeviceDetailsCopyWithImpl<$Res, DeviceDetails>;
  @useResult
  $Res call({String id, String name, String vendor, String osVersion});
}

/// @nodoc
class _$DeviceDetailsCopyWithImpl<$Res, $Val extends DeviceDetails>
    implements $DeviceDetailsCopyWith<$Res> {
  _$DeviceDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? vendor = null,
    Object? osVersion = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: null == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeviceDetailsCopyWith<$Res>
    implements $DeviceDetailsCopyWith<$Res> {
  factory _$$_DeviceDetailsCopyWith(
          _$_DeviceDetails value, $Res Function(_$_DeviceDetails) then) =
      __$$_DeviceDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String vendor, String osVersion});
}

/// @nodoc
class __$$_DeviceDetailsCopyWithImpl<$Res>
    extends _$DeviceDetailsCopyWithImpl<$Res, _$_DeviceDetails>
    implements _$$_DeviceDetailsCopyWith<$Res> {
  __$$_DeviceDetailsCopyWithImpl(
      _$_DeviceDetails _value, $Res Function(_$_DeviceDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? vendor = null,
    Object? osVersion = null,
  }) {
    return _then(_$_DeviceDetails(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: null == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: null == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_DeviceDetails implements _DeviceDetails {
  _$_DeviceDetails(
      {this.id = '', this.name = '', this.vendor = '', this.osVersion = ''});

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String vendor;
  @override
  @JsonKey()
  final String osVersion;

  @override
  String toString() {
    return 'DeviceDetails(id: $id, name: $name, vendor: $vendor, osVersion: $osVersion)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeviceDetailsCopyWith<_$_DeviceDetails> get copyWith =>
      __$$_DeviceDetailsCopyWithImpl<_$_DeviceDetails>(this, _$identity);
}

abstract class _DeviceDetails implements DeviceDetails {
  factory _DeviceDetails(
      {final String id,
      final String name,
      final String vendor,
      final String osVersion}) = _$_DeviceDetails;

  @override
  String get id;
  @override
  String get name;
  @override
  String get vendor;
  @override
  String get osVersion;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceDetailsCopyWith<_$_DeviceDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
