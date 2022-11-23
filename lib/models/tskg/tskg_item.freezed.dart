// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tskg_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TskgItem _$TskgItemFromJson(Map<String, dynamic> json) {
  return _TskgItem.fromJson(json);
}

/// @nodoc
mixin _$TskgItem {
  String get showId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String> get badges => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get genres => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TskgItemCopyWith<TskgItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TskgItemCopyWith<$Res> {
  factory $TskgItemCopyWith(TskgItem value, $Res Function(TskgItem) then) =
      _$TskgItemCopyWithImpl<$Res, TskgItem>;
  @useResult
  $Res call(
      {String showId,
      DateTime date,
      List<String> badges,
      String title,
      String subtitle,
      String genres,
      String link});
}

/// @nodoc
class _$TskgItemCopyWithImpl<$Res, $Val extends TskgItem>
    implements $TskgItemCopyWith<$Res> {
  _$TskgItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showId = null,
    Object? date = null,
    Object? badges = null,
    Object? title = null,
    Object? subtitle = null,
    Object? genres = null,
    Object? link = null,
  }) {
    return _then(_value.copyWith(
      showId: null == showId
          ? _value.showId
          : showId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TskgItemCopyWith<$Res> implements $TskgItemCopyWith<$Res> {
  factory _$$_TskgItemCopyWith(
          _$_TskgItem value, $Res Function(_$_TskgItem) then) =
      __$$_TskgItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String showId,
      DateTime date,
      List<String> badges,
      String title,
      String subtitle,
      String genres,
      String link});
}

/// @nodoc
class __$$_TskgItemCopyWithImpl<$Res>
    extends _$TskgItemCopyWithImpl<$Res, _$_TskgItem>
    implements _$$_TskgItemCopyWith<$Res> {
  __$$_TskgItemCopyWithImpl(
      _$_TskgItem _value, $Res Function(_$_TskgItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showId = null,
    Object? date = null,
    Object? badges = null,
    Object? title = null,
    Object? subtitle = null,
    Object? genres = null,
    Object? link = null,
  }) {
    return _then(_$_TskgItem(
      showId: null == showId
          ? _value.showId
          : showId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      badges: null == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TskgItem implements _TskgItem {
  const _$_TskgItem(
      {required this.showId,
      required this.date,
      final List<String> badges = const [],
      this.title = '',
      this.subtitle = '',
      this.genres = '',
      this.link = ''})
      : _badges = badges;

  factory _$_TskgItem.fromJson(Map<String, dynamic> json) =>
      _$$_TskgItemFromJson(json);

  @override
  final String showId;
  @override
  final DateTime date;
  final List<String> _badges;
  @override
  @JsonKey()
  List<String> get badges {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  @JsonKey()
  final String genres;
  @override
  @JsonKey()
  final String link;

  @override
  String toString() {
    return 'TskgItem(showId: $showId, date: $date, badges: $badges, title: $title, subtitle: $subtitle, genres: $genres, link: $link)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TskgItem &&
            (identical(other.showId, showId) || other.showId == showId) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.genres, genres) || other.genres == genres) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      showId,
      date,
      const DeepCollectionEquality().hash(_badges),
      title,
      subtitle,
      genres,
      link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TskgItemCopyWith<_$_TskgItem> get copyWith =>
      __$$_TskgItemCopyWithImpl<_$_TskgItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TskgItemToJson(
      this,
    );
  }
}

abstract class _TskgItem implements TskgItem {
  const factory _TskgItem(
      {required final String showId,
      required final DateTime date,
      final List<String> badges,
      final String title,
      final String subtitle,
      final String genres,
      final String link}) = _$_TskgItem;

  factory _TskgItem.fromJson(Map<String, dynamic> json) = _$_TskgItem.fromJson;

  @override
  String get showId;
  @override
  DateTime get date;
  @override
  List<String> get badges;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get genres;
  @override
  String get link;
  @override
  @JsonKey(ignore: true)
  _$$_TskgItemCopyWith<_$_TskgItem> get copyWith =>
      throw _privateConstructorUsedError;
}
