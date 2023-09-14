// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return _MediaItem.fromJson(json);
}

/// @nodoc
mixin _$MediaItem {
  String get title => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  String get posterUrl => throw _privateConstructorUsedError;
  String get backdropUrl => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaItemCopyWith<MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemCopyWith<$Res> {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) then) =
      _$MediaItemCopyWithImpl<$Res, MediaItem>;
  @useResult
  $Res call(
      {String title,
      String overview,
      String posterUrl,
      String backdropUrl,
      List<String> genres});
}

/// @nodoc
class _$MediaItemCopyWithImpl<$Res, $Val extends MediaItem>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? overview = null,
    Object? posterUrl = null,
    Object? backdropUrl = null,
    Object? genres = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: null == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String,
      backdropUrl: null == backdropUrl
          ? _value.backdropUrl
          : backdropUrl // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MediaItemCopyWith<$Res> implements $MediaItemCopyWith<$Res> {
  factory _$$_MediaItemCopyWith(
          _$_MediaItem value, $Res Function(_$_MediaItem) then) =
      __$$_MediaItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String overview,
      String posterUrl,
      String backdropUrl,
      List<String> genres});
}

/// @nodoc
class __$$_MediaItemCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$_MediaItem>
    implements _$$_MediaItemCopyWith<$Res> {
  __$$_MediaItemCopyWithImpl(
      _$_MediaItem _value, $Res Function(_$_MediaItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? overview = null,
    Object? posterUrl = null,
    Object? backdropUrl = null,
    Object? genres = null,
  }) {
    return _then(_$_MediaItem(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: null == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String,
      backdropUrl: null == backdropUrl
          ? _value.backdropUrl
          : backdropUrl // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MediaItem with DiagnosticableTreeMixin implements _MediaItem {
  const _$_MediaItem(
      {this.title = '',
      this.overview = '',
      this.posterUrl = '',
      this.backdropUrl = '',
      final List<String> genres = const []})
      : _genres = genres;

  factory _$_MediaItem.fromJson(Map<String, dynamic> json) =>
      _$$_MediaItemFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String overview;
  @override
  @JsonKey()
  final String posterUrl;
  @override
  @JsonKey()
  final String backdropUrl;
  final List<String> _genres;
  @override
  @JsonKey()
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MediaItem(title: $title, overview: $overview, posterUrl: $posterUrl, backdropUrl: $backdropUrl, genres: $genres)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MediaItem'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('overview', overview))
      ..add(DiagnosticsProperty('posterUrl', posterUrl))
      ..add(DiagnosticsProperty('backdropUrl', backdropUrl))
      ..add(DiagnosticsProperty('genres', genres));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.backdropUrl, backdropUrl) ||
                other.backdropUrl == backdropUrl) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, overview, posterUrl,
      backdropUrl, const DeepCollectionEquality().hash(_genres));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MediaItemCopyWith<_$_MediaItem> get copyWith =>
      __$$_MediaItemCopyWithImpl<_$_MediaItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MediaItemToJson(
      this,
    );
  }
}

abstract class _MediaItem implements MediaItem {
  const factory _MediaItem(
      {final String title,
      final String overview,
      final String posterUrl,
      final String backdropUrl,
      final List<String> genres}) = _$_MediaItem;

  factory _MediaItem.fromJson(Map<String, dynamic> json) =
      _$_MediaItem.fromJson;

  @override
  String get title;
  @override
  String get overview;
  @override
  String get posterUrl;
  @override
  String get backdropUrl;
  @override
  List<String> get genres;
  @override
  @JsonKey(ignore: true)
  _$$_MediaItemCopyWith<_$_MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}
