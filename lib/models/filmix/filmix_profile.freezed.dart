// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filmix_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilmixProfile _$FilmixProfileFromJson(Map<String, dynamic> json) {
  return _FilmixProfile.fromJson(json);
}

/// @nodoc
mixin _$FilmixProfile {
  FilmixProfileData get userData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilmixProfileCopyWith<FilmixProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixProfileCopyWith<$Res> {
  factory $FilmixProfileCopyWith(
          FilmixProfile value, $Res Function(FilmixProfile) then) =
      _$FilmixProfileCopyWithImpl<$Res, FilmixProfile>;
  @useResult
  $Res call({FilmixProfileData userData});

  $FilmixProfileDataCopyWith<$Res> get userData;
}

/// @nodoc
class _$FilmixProfileCopyWithImpl<$Res, $Val extends FilmixProfile>
    implements $FilmixProfileCopyWith<$Res> {
  _$FilmixProfileCopyWithImpl(this._value, this._then);

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
              as FilmixProfileData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FilmixProfileDataCopyWith<$Res> get userData {
    return $FilmixProfileDataCopyWith<$Res>(_value.userData, (value) {
      return _then(_value.copyWith(userData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FilmixProfileImplCopyWith<$Res>
    implements $FilmixProfileCopyWith<$Res> {
  factory _$$FilmixProfileImplCopyWith(
          _$FilmixProfileImpl value, $Res Function(_$FilmixProfileImpl) then) =
      __$$FilmixProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FilmixProfileData userData});

  @override
  $FilmixProfileDataCopyWith<$Res> get userData;
}

/// @nodoc
class __$$FilmixProfileImplCopyWithImpl<$Res>
    extends _$FilmixProfileCopyWithImpl<$Res, _$FilmixProfileImpl>
    implements _$$FilmixProfileImplCopyWith<$Res> {
  __$$FilmixProfileImplCopyWithImpl(
      _$FilmixProfileImpl _value, $Res Function(_$FilmixProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userData = null,
  }) {
    return _then(_$FilmixProfileImpl(
      userData: null == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as FilmixProfileData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$FilmixProfileImpl implements _FilmixProfile {
  const _$FilmixProfileImpl({required this.userData});

  factory _$FilmixProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilmixProfileImplFromJson(json);

  @override
  final FilmixProfileData userData;

  @override
  String toString() {
    return 'FilmixProfile(userData: $userData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilmixProfileImpl &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilmixProfileImplCopyWith<_$FilmixProfileImpl> get copyWith =>
      __$$FilmixProfileImplCopyWithImpl<_$FilmixProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilmixProfileImplToJson(
      this,
    );
  }
}

abstract class _FilmixProfile implements FilmixProfile {
  const factory _FilmixProfile({required final FilmixProfileData userData}) =
      _$FilmixProfileImpl;

  factory _FilmixProfile.fromJson(Map<String, dynamic> json) =
      _$FilmixProfileImpl.fromJson;

  @override
  FilmixProfileData get userData;
  @override
  @JsonKey(ignore: true)
  _$$FilmixProfileImplCopyWith<_$FilmixProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FilmixProfileData _$FilmixProfileDataFromJson(Map<String, dynamic> json) {
  return _FilmixProfileData.fromJson(json);
}

/// @nodoc
mixin _$FilmixProfileData {
  String get login => throw _privateConstructorUsedError;
  bool get isPro => throw _privateConstructorUsedError;
  bool get isProPlus => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get videoserver => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilmixProfileDataCopyWith<FilmixProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmixProfileDataCopyWith<$Res> {
  factory $FilmixProfileDataCopyWith(
          FilmixProfileData value, $Res Function(FilmixProfileData) then) =
      _$FilmixProfileDataCopyWithImpl<$Res, FilmixProfileData>;
  @useResult
  $Res call(
      {String login,
      bool isPro,
      bool isProPlus,
      String displayName,
      String videoserver});
}

/// @nodoc
class _$FilmixProfileDataCopyWithImpl<$Res, $Val extends FilmixProfileData>
    implements $FilmixProfileDataCopyWith<$Res> {
  _$FilmixProfileDataCopyWithImpl(this._value, this._then);

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
abstract class _$$FilmixProfileDataImplCopyWith<$Res>
    implements $FilmixProfileDataCopyWith<$Res> {
  factory _$$FilmixProfileDataImplCopyWith(_$FilmixProfileDataImpl value,
          $Res Function(_$FilmixProfileDataImpl) then) =
      __$$FilmixProfileDataImplCopyWithImpl<$Res>;
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
class __$$FilmixProfileDataImplCopyWithImpl<$Res>
    extends _$FilmixProfileDataCopyWithImpl<$Res, _$FilmixProfileDataImpl>
    implements _$$FilmixProfileDataImplCopyWith<$Res> {
  __$$FilmixProfileDataImplCopyWithImpl(_$FilmixProfileDataImpl _value,
      $Res Function(_$FilmixProfileDataImpl) _then)
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
    return _then(_$FilmixProfileDataImpl(
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
class _$FilmixProfileDataImpl implements _FilmixProfileData {
  const _$FilmixProfileDataImpl(
      {this.login = '',
      this.isPro = false,
      this.isProPlus = false,
      this.displayName = '',
      this.videoserver = ''});

  factory _$FilmixProfileDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilmixProfileDataImplFromJson(json);

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
    return 'FilmixProfileData(login: $login, isPro: $isPro, isProPlus: $isProPlus, displayName: $displayName, videoserver: $videoserver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilmixProfileDataImpl &&
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
  _$$FilmixProfileDataImplCopyWith<_$FilmixProfileDataImpl> get copyWith =>
      __$$FilmixProfileDataImplCopyWithImpl<_$FilmixProfileDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilmixProfileDataImplToJson(
      this,
    );
  }
}

abstract class _FilmixProfileData implements FilmixProfileData {
  const factory _FilmixProfileData(
      {final String login,
      final bool isPro,
      final bool isProPlus,
      final String displayName,
      final String videoserver}) = _$FilmixProfileDataImpl;

  factory _FilmixProfileData.fromJson(Map<String, dynamic> json) =
      _$FilmixProfileDataImpl.fromJson;

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
  _$$FilmixProfileDataImplCopyWith<_$FilmixProfileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
