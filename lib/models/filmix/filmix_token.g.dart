// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilmixTokenImpl _$$FilmixTokenImplFromJson(Map<String, dynamic> json) =>
    _$FilmixTokenImpl(
      code: json['code'] as String? ?? '',
      userCode: json['user_code'] as String? ?? '',
      expire: json['expire'] as int? ?? 0,
    );

Map<String, dynamic> _$$FilmixTokenImplToJson(_$FilmixTokenImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'user_code': instance.userCode,
      'expire': instance.expire,
    };
