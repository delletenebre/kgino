// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flmx_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FlmxToken _$$_FlmxTokenFromJson(Map<String, dynamic> json) => _$_FlmxToken(
      code: json['code'] as String? ?? '',
      userCode: json['user_code'] as String? ?? '',
      expire: json['expire'] as int? ?? 0,
    );

Map<String, dynamic> _$$_FlmxTokenToJson(_$_FlmxToken instance) =>
    <String, dynamic>{
      'code': instance.code,
      'user_code': instance.userCode,
      'expire': instance.expire,
    };
