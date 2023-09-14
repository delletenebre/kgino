// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flmx_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FlmxProfile _$FlmxProfileFromJson(Map<String, dynamic> json) {
  return _FlmxProfile.fromJson(json);
}

/// @nodoc
mixin _$FlmxProfile {
  FlmxProfileData get userData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlmxProfileCopyWith<FlmxProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlmxProfileCopyWith<$Res> {
  factory $FlmxProfileCopyWith(
          FlmxProfile value, $Res Function(FlmxProfile) then) =
      _$FlmxProfileCopyWithImpl<$Res, FlmxProfile>;
  @useResult
  $Res call({FlmxProfileData userData});

  $FlmxProfileDataCopyWith<$Res> get userData;
}

/// @nodoc
class _$FlmxProfileCopyWithImpl<$Res, $Val extends FlmxProfile>
    implements $FlmxProfileCopyWith<$Res> {
  _$FlmxProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userData = null,
  }) {
    return _then(_value.copyWith(
      userData: null == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as FlmxProfileData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FlmxProfileDataCopyWith<$Res> get userData {
    return $FlmxProfileDataCopyWith<$Res>(_value.userData, (value) {
      return _then(_value.copyWith(userData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FlmxProfileCopyWith<$Res>
    implements $FlmxProfileCopyWith<$Res> {
  factory _$$_FlmxProfileCopyWith(
          _$_FlmxProfile value, $Res Function(_$_FlmxProfile) then) =
      __$$_FlmxProfileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FlmxProfileData userData});

  @override
  $FlmxProfileDataCopyWith<$Res> get userData;
}

/// @nodoc
class __$$_FlmxProfileCopyWithImpl<$Res>
    extends _$FlmxProfileCopyWithImpl<$Res, _$_FlmxProfile>
    implements _$$_FlmxProfileCopyWith<$Res> {
  __$$_FlmxProfileCopyWithImpl(
      _$_FlmxProfile _value, $Res Function(_$_FlmxProfile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userData = null,
  }) {
    return _then(_$_FlmxProfile(
      userData: null == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as FlmxProfileData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_FlmxProfile implements _FlmxProfile {
  const _$_FlmxProfile({required this.userData});

  factory _$_FlmxProfile.fromJson(Map<String, dynamic> json) =>
      _$$_FlmxProfileFromJson(json);

  @override
  final FlmxProfileData userData;

  @override
  String toString() {
    return 'FlmxProfile(userData: $userData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlmxProfile &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlmxProfileCopyWith<_$_FlmxProfile> get copyWith =>
      __$$_FlmxProfileCopyWithImpl<_$_FlmxProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FlmxProfileToJson(
      this,
    );
  }
}

abstract class _FlmxProfile implements FlmxProfile {
  const factory _FlmxProfile({required final FlmxProfileData userData}) =
      _$_FlmxProfile;

  factory _FlmxProfile.fromJson(Map<String, dynamic> json) =
      _$_FlmxProfile.fromJson;

  @override
  FlmxProfileData get userData;
  @override
  @JsonKey(ignore: true)
  _$$_FlmxProfileCopyWith<_$_FlmxProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

FlmxProfileData _$FlmxProfileDataFromJson(Map<String, dynamic> json) {
  return _FlmxProfileData.fromJson(json);
}

/// @nodoc
mixin _$FlmxProfileData {
  String get login => throw _privateConstructorUsedError;
  bool get isPro => throw _privateConstructorUsedError;
  bool get isProPlus => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get videoserver => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlmxProfileDataCopyWith<FlmxProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlmxProfileDataCopyWith<$Res> {
  factory $FlmxProfileDataCopyWith(
          FlmxProfileData value, $Res Function(FlmxProfileData) then) =
      _$FlmxProfileDataCopyWithImpl<$Res, FlmxProfileData>;
  @useResult
  $Res call(
      {String login,
      bool isPro,
      bool isProPlus,
      String displayName,
      String videoserver});
}

/// @nodoc
class _$FlmxProfileDataCopyWithImpl<$Res, $Val extends FlmxProfileData>
    implements $FlmxProfileDataCopyWith<$Res> {
  _$FlmxProfileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? isPro = null,
    Object? isProPlus = null,
    Object? displayName = null,
    Object? videoserver = null,
  }) {
    return _then(_value.copyWith(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      isPro: null == isPro
          ? _value.isPro
          : isPro // ignore: cast_nullable_to_non_nullable
              as bool,
      isProPlus: null == isProPlus
          ? _value.isProPlus
          : isProPlus // ignore: cast_nullable_to_non_nullable
              as bool,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      videoserver: null == videoserver
          ? _value.videoserver
          : videoserver // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FlmxProfileDataCopyWith<$Res>
    implements $FlmxProfileDataCopyWith<$Res> {
  factory _$$_FlmxProfileDataCopyWith(
          _$_FlmxProfileData value, $Res Function(_$_FlmxProfileData) then) =
      __$$_FlmxProfileDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String login,
      bool isPro,
      bool isProPlus,
      String displayName,
      String videoserver});
}

/// @nodoc
class __$$_FlmxProfileDataCopyWithImpl<$Res>
    extends _$FlmxProfileDataCopyWithImpl<$Res, _$_FlmxProfileData>
    implements _$$_FlmxProfileDataCopyWith<$Res> {
  __$$_FlmxProfileDataCopyWithImpl(
      _$_FlmxProfileData _value, $Res Function(_$_FlmxProfileData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? isPro = null,
    Object? isProPlus = null,
    Object? displayName = null,
    Object? videoserver = null,
  }) {
    return _then(_$_FlmxProfileData(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      isPro: null == isPro
          ? _value.isPro
          : isPro // ignore: cast_nullable_to_non_nullable
              as bool,
      isProPlus: null == isProPlus
          ? _value.isProPlus
          : isProPlus // ignore: cast_nullable_to_non_nullable
              as bool,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      videoserver: null == videoserver
          ? _value.videoserver
          : videoserver // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_FlmxProfileData implements _FlmxProfileData {
  const _$_FlmxProfileData(
      {this.login = '',
      this.isPro = false,
      this.isProPlus = false,
      this.displayName = '',
      this.videoserver = ''});

  factory _$_FlmxProfileData.fromJson(Map<String, dynamic> json) =>
      _$$_FlmxProfileDataFromJson(json);

  @override
  @JsonKey()
  final String login;
  @override
  @JsonKey()
  final bool isPro;
  @override
  @JsonKey()
  final bool isProPlus;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String videoserver;

  @override
  String toString() {
    return 'FlmxProfileData(login: $login, isPro: $isPro, isProPlus: $isProPlus, displayName: $displayName, videoserver: $videoserver)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlmxProfileData &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.isPro, isPro) || other.isPro == isPro) &&
            (identical(other.isProPlus, isProPlus) ||
                other.isProPlus == isProPlus) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.videoserver, videoserver) ||
                other.videoserver == videoserver));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, login, isPro, isProPlus, displayName, videoserver);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlmxProfileDataCopyWith<_$_FlmxProfileData> get copyWith =>
      __$$_FlmxProfileDataCopyWithImpl<_$_FlmxProfileData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FlmxProfileDataToJson(
      this,
    );
  }
}

abstract class _FlmxProfileData implements FlmxProfileData {
  const factory _FlmxProfileData(
      {final String login,
      final bool isPro,
      final bool isProPlus,
      final String displayName,
      final String videoserver}) = _$_FlmxProfileData;

  factory _FlmxProfileData.fromJson(Map<String, dynamic> json) =
      _$_FlmxProfileData.fromJson;

  @override
  String get login;
  @override
  bool get isPro;
  @override
  bool get isProPlus;
  @override
  String get displayName;
  @override
  String get videoserver;
  @override
  @JsonKey(ignore: true)
  _$$_FlmxProfileDataCopyWith<_$_FlmxProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}
