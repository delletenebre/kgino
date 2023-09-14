// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flmx_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FlmxProfile _$$_FlmxProfileFromJson(Map<String, dynamic> json) =>
    _$_FlmxProfile(
      userData:
          FlmxProfileData.fromJson(json['user_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FlmxProfileToJson(_$_FlmxProfile instance) =>
    <String, dynamic>{
      'user_data': instance.userData,
    };

_$_FlmxProfileData _$$_FlmxProfileDataFromJson(Map<String, dynamic> json) =>
    _$_FlmxProfileData(
      login: json['login'] as String? ?? '',
      isPro: json['is_pro'] as bool? ?? false,
      isProPlus: json['is_pro_plus'] as bool? ?? false,
      displayName: json['display_name'] as String? ?? '',
      videoserver: json['videoserver'] as String? ?? '',
    );

Map<String, dynamic> _$$_FlmxProfileDataToJson(_$_FlmxProfileData instance) =>
    <String, dynamic>{
      'login': instance.login,
      'is_pro': instance.isPro,
      'is_pro_plus': instance.isProPlus,
      'display_name': instance.displayName,
      'videoserver': instance.videoserver,
    };
