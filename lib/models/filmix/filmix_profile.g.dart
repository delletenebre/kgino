// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filmix_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilmixProfileImpl _$$FilmixProfileImplFromJson(Map<String, dynamic> json) =>
    _$FilmixProfileImpl(
      userData:
          FilmixProfileData.fromJson(json['user_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FilmixProfileImplToJson(_$FilmixProfileImpl instance) =>
    <String, dynamic>{
      'user_data': instance.userData,
    };

_$FilmixProfileDataImpl _$$FilmixProfileDataImplFromJson(
        Map<String, dynamic> json) =>
    _$FilmixProfileDataImpl(
      login: json['login'] as String? ?? '',
      isPro: json['is_pro'] as bool? ?? false,
      isProPlus: json['is_pro_plus'] as bool? ?? false,
      displayName: json['display_name'] as String? ?? '',
      videoserver: json['videoserver'] as String? ?? '',
    );

Map<String, dynamic> _$$FilmixProfileDataImplToJson(
        _$FilmixProfileDataImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
      'is_pro': instance.isPro,
      'is_pro_plus': instance.isProPlus,
      'display_name': instance.displayName,
      'videoserver': instance.videoserver,
    };
