// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tskg_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TskgVideo _$TskgVideoFromJson(Map<String, dynamic> json) {
  return _TskgVideo.fromJson(json);
}

/// @nodoc
mixin _$TskgVideo {
  @JsonKey(name: 'HD')
  bool get hd => throw _privateConstructorUsedError;
  TskgVideoFiles get files => throw _privateConstructorUsedError;
  String get mimetype => throw _privateConstructorUsedError;
  String get videotype => throw _privateConstructorUsedError;
  String get subtitles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TskgVideoCopyWith<TskgVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgVideoCopyWith<$Res> {
  factory $TskgVideoCopyWith(TskgVideo value, $Res Function(TskgVideo) then) =
      _$TskgVideoCopyWithImpl<$Res, TskgVideo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'HD') bool hd,
      TskgVideoFiles files,
      String mimetype,
      String videotype,
      String subtitles});

  $TskgVideoFilesCopyWith<$Res> get files;
}

/// @nodoc
class _$TskgVideoCopyWithImpl<$Res, $Val extends TskgVideo>
    implements $TskgVideoCopyWith<$Res> {
  _$TskgVideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hd = null,
    Object? files = null,
    Object? mimetype = null,
    Object? videotype = null,
    Object? subtitles = null,
  }) {
    return _then(_value.copyWith(
      hd: null == hd
          ? _value.hd
          : hd // ignore: cast_nullable_to_non_nullable
              as bool,
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as TskgVideoFiles,
      mimetype: null == mimetype
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      videotype: null == videotype
          ? _value.videotype
          : videotype // ignore: cast_nullable_to_non_nullable
              as String,
      subtitles: null == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TskgVideoFilesCopyWith<$Res> get files {
    return $TskgVideoFilesCopyWith<$Res>(_value.files, (value) {
      return _then(_value.copyWith(files: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TskgVideoCopyWith<$Res> implements $TskgVideoCopyWith<$Res> {
  factory _$$_TskgVideoCopyWith(
          _$_TskgVideo value, $Res Function(_$_TskgVideo) then) =
      __$$_TskgVideoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'HD') bool hd,
      TskgVideoFiles files,
      String mimetype,
      String videotype,
      String subtitles});

  @override
  $TskgVideoFilesCopyWith<$Res> get files;
}

/// @nodoc
class __$$_TskgVideoCopyWithImpl<$Res>
    extends _$TskgVideoCopyWithImpl<$Res, _$_TskgVideo>
    implements _$$_TskgVideoCopyWith<$Res> {
  __$$_TskgVideoCopyWithImpl(
      _$_TskgVideo _value, $Res Function(_$_TskgVideo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hd = null,
    Object? files = null,
    Object? mimetype = null,
    Object? videotype = null,
    Object? subtitles = null,
  }) {
    return _then(_$_TskgVideo(
      hd: null == hd
          ? _value.hd
          : hd // ignore: cast_nullable_to_non_nullable
              as bool,
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as TskgVideoFiles,
      mimetype: null == mimetype
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      videotype: null == videotype
          ? _value.videotype
          : videotype // ignore: cast_nullable_to_non_nullable
              as String,
      subtitles: null == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TskgVideo implements _TskgVideo {
  const _$_TskgVideo(
      {@JsonKey(name: 'HD') this.hd = false,
      required this.files,
      this.mimetype = '',
      this.videotype = '',
      this.subtitles = ''});

  factory _$_TskgVideo.fromJson(Map<String, dynamic> json) =>
      _$$_TskgVideoFromJson(json);

  @override
  @JsonKey(name: 'HD')
  final bool hd;
  @override
  final TskgVideoFiles files;
  @override
  @JsonKey()
  final String mimetype;
  @override
  @JsonKey()
  final String videotype;
  @override
  @JsonKey()
  final String subtitles;

  @override
  String toString() {
    return 'TskgVideo(hd: $hd, files: $files, mimetype: $mimetype, videotype: $videotype, subtitles: $subtitles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgVideo &&
            (identical(other.hd, hd) || other.hd == hd) &&
            (identical(other.files, files) || other.files == files) &&
            (identical(other.mimetype, mimetype) ||
                other.mimetype == mimetype) &&
            (identical(other.videotype, videotype) ||
                other.videotype == videotype) &&
            (identical(other.subtitles, subtitles) ||
                other.subtitles == subtitles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hd, files, mimetype, videotype, subtitles);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgVideoCopyWith<_$_TskgVideo> get copyWith =>
      __$$_TskgVideoCopyWithImpl<_$_TskgVideo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TskgVideoToJson(
      this,
    );
  }
}

abstract class _TskgVideo implements TskgVideo {
  const factory _TskgVideo(
      {@JsonKey(name: 'HD') final bool hd,
      required final TskgVideoFiles files,
      final String mimetype,
      final String videotype,
      final String subtitles}) = _$_TskgVideo;

  factory _TskgVideo.fromJson(Map<String, dynamic> json) =
      _$_TskgVideo.fromJson;

  @override
  @JsonKey(name: 'HD')
  bool get hd;
  @override
  TskgVideoFiles get files;
  @override
  String get mimetype;
  @override
  String get videotype;
  @override
  String get subtitles;
  @override
  @JsonKey(ignore: true)
  _$$_TskgVideoCopyWith<_$_TskgVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

TskgVideoFiles _$TskgVideoFilesFromJson(Map<String, dynamic> json) {
  return _TskgVideoFiles.fromJson(json);
}

/// @nodoc
mixin _$TskgVideoFiles {
  @JsonKey(name: 'HD')
  TskgVideoFile get hd => throw _privateConstructorUsedError;
  @JsonKey(name: 'SD')
  TskgVideoFile get sd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TskgVideoFilesCopyWith<TskgVideoFiles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgVideoFilesCopyWith<$Res> {
  factory $TskgVideoFilesCopyWith(
          TskgVideoFiles value, $Res Function(TskgVideoFiles) then) =
      _$TskgVideoFilesCopyWithImpl<$Res, TskgVideoFiles>;
  @useResult
  $Res call(
      {@JsonKey(name: 'HD') TskgVideoFile hd,
      @JsonKey(name: 'SD') TskgVideoFile sd});

  $TskgVideoFileCopyWith<$Res> get hd;
  $TskgVideoFileCopyWith<$Res> get sd;
}

/// @nodoc
class _$TskgVideoFilesCopyWithImpl<$Res, $Val extends TskgVideoFiles>
    implements $TskgVideoFilesCopyWith<$Res> {
  _$TskgVideoFilesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hd = null,
    Object? sd = null,
  }) {
    return _then(_value.copyWith(
      hd: null == hd
          ? _value.hd
          : hd // ignore: cast_nullable_to_non_nullable
              as TskgVideoFile,
      sd: null == sd
          ? _value.sd
          : sd // ignore: cast_nullable_to_non_nullable
              as TskgVideoFile,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TskgVideoFileCopyWith<$Res> get hd {
    return $TskgVideoFileCopyWith<$Res>(_value.hd, (value) {
      return _then(_value.copyWith(hd: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TskgVideoFileCopyWith<$Res> get sd {
    return $TskgVideoFileCopyWith<$Res>(_value.sd, (value) {
      return _then(_value.copyWith(sd: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TskgVideoFilesCopyWith<$Res>
    implements $TskgVideoFilesCopyWith<$Res> {
  factory _$$_TskgVideoFilesCopyWith(
          _$_TskgVideoFiles value, $Res Function(_$_TskgVideoFiles) then) =
      __$$_TskgVideoFilesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'HD') TskgVideoFile hd,
      @JsonKey(name: 'SD') TskgVideoFile sd});

  @override
  $TskgVideoFileCopyWith<$Res> get hd;
  @override
  $TskgVideoFileCopyWith<$Res> get sd;
}

/// @nodoc
class __$$_TskgVideoFilesCopyWithImpl<$Res>
    extends _$TskgVideoFilesCopyWithImpl<$Res, _$_TskgVideoFiles>
    implements _$$_TskgVideoFilesCopyWith<$Res> {
  __$$_TskgVideoFilesCopyWithImpl(
      _$_TskgVideoFiles _value, $Res Function(_$_TskgVideoFiles) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hd = null,
    Object? sd = null,
  }) {
    return _then(_$_TskgVideoFiles(
      hd: null == hd
          ? _value.hd
          : hd // ignore: cast_nullable_to_non_nullable
              as TskgVideoFile,
      sd: null == sd
          ? _value.sd
          : sd // ignore: cast_nullable_to_non_nullable
              as TskgVideoFile,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TskgVideoFiles implements _TskgVideoFiles {
  const _$_TskgVideoFiles(
      {@JsonKey(name: 'HD') required this.hd,
      @JsonKey(name: 'SD') required this.sd});

  factory _$_TskgVideoFiles.fromJson(Map<String, dynamic> json) =>
      _$$_TskgVideoFilesFromJson(json);

  @override
  @JsonKey(name: 'HD')
  final TskgVideoFile hd;
  @override
  @JsonKey(name: 'SD')
  final TskgVideoFile sd;

  @override
  String toString() {
    return 'TskgVideoFiles(hd: $hd, sd: $sd)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgVideoFiles &&
            (identical(other.hd, hd) || other.hd == hd) &&
            (identical(other.sd, sd) || other.sd == sd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hd, sd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgVideoFilesCopyWith<_$_TskgVideoFiles> get copyWith =>
      __$$_TskgVideoFilesCopyWithImpl<_$_TskgVideoFiles>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TskgVideoFilesToJson(
      this,
    );
  }
}

abstract class _TskgVideoFiles implements TskgVideoFiles {
  const factory _TskgVideoFiles(
          {@JsonKey(name: 'HD') required final TskgVideoFile hd,
          @JsonKey(name: 'SD') required final TskgVideoFile sd}) =
      _$_TskgVideoFiles;

  factory _TskgVideoFiles.fromJson(Map<String, dynamic> json) =
      _$_TskgVideoFiles.fromJson;

  @override
  @JsonKey(name: 'HD')
  TskgVideoFile get hd;
  @override
  @JsonKey(name: 'SD')
  TskgVideoFile get sd;
  @override
  @JsonKey(ignore: true)
  _$$_TskgVideoFilesCopyWith<_$_TskgVideoFiles> get copyWith =>
      throw _privateConstructorUsedError;
}

TskgVideoFile _$TskgVideoFileFromJson(Map<String, dynamic> json) {
  return _TskgVideoFile.fromJson(json);
}

/// @nodoc
mixin _$TskgVideoFile {
  int get id => throw _privateConstructorUsedError;
  String get server => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TskgVideoFileCopyWith<TskgVideoFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgVideoFileCopyWith<$Res> {
  factory $TskgVideoFileCopyWith(
          TskgVideoFile value, $Res Function(TskgVideoFile) then) =
      _$TskgVideoFileCopyWithImpl<$Res, TskgVideoFile>;
  @useResult
  $Res call({int id, String server, String? url});
}

/// @nodoc
class _$TskgVideoFileCopyWithImpl<$Res, $Val extends TskgVideoFile>
    implements $TskgVideoFileCopyWith<$Res> {
  _$TskgVideoFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? server = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TskgVideoFileCopyWith<$Res>
    implements $TskgVideoFileCopyWith<$Res> {
  factory _$$_TskgVideoFileCopyWith(
          _$_TskgVideoFile value, $Res Function(_$_TskgVideoFile) then) =
      __$$_TskgVideoFileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String server, String? url});
}

/// @nodoc
class __$$_TskgVideoFileCopyWithImpl<$Res>
    extends _$TskgVideoFileCopyWithImpl<$Res, _$_TskgVideoFile>
    implements _$$_TskgVideoFileCopyWith<$Res> {
  __$$_TskgVideoFileCopyWithImpl(
      _$_TskgVideoFile _value, $Res Function(_$_TskgVideoFile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? server = null,
    Object? url = freezed,
  }) {
    return _then(_$_TskgVideoFile(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TskgVideoFile implements _TskgVideoFile {
  const _$_TskgVideoFile({this.id = 0, this.server = '', this.url});

  factory _$_TskgVideoFile.fromJson(Map<String, dynamic> json) =>
      _$$_TskgVideoFileFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String server;
  @override
  final String? url;

  @override
  String toString() {
    return 'TskgVideoFile(id: $id, server: $server, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgVideoFile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.server, server) || other.server == server) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, server, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgVideoFileCopyWith<_$_TskgVideoFile> get copyWith =>
      __$$_TskgVideoFileCopyWithImpl<_$_TskgVideoFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TskgVideoFileToJson(
      this,
    );
  }
}

abstract class _TskgVideoFile implements TskgVideoFile {
  const factory _TskgVideoFile(
      {final int id,
      final String server,
      final String? url}) = _$_TskgVideoFile;

  factory _TskgVideoFile.fromJson(Map<String, dynamic> json) =
      _$_TskgVideoFile.fromJson;

  @override
  int get id;
  @override
  String get server;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$_TskgVideoFileCopyWith<_$_TskgVideoFile> get copyWith =>
      throw _privateConstructorUsedError;
}
