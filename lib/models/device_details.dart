import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'device_details.freezed.dart';

@freezed
class DeviceDetails with _$DeviceDetails {
  factory DeviceDetails({
    @Default('') final String id,
    @Default('') final String name,
    @Default('') final String vendor,
    @Default('') final String osVersion,
  }) = _DeviceDetails;

  static Future<DeviceDetails> initialize() async {
    /// инициализируем локальное хранилище
    final sharedPreferences = await SharedPreferences.getInstance();

    /// считываем или генерируем идентификатор установки
    final installationId = sharedPreferences.getString(
          'id',
        ) ??
        const Uuid().v4();

    /// сохраняем идентификатор установки
    sharedPreferences.setString('id', installationId);

    print(installationId);

    /// инициализируем информацию об устройстве
    final deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      /// ^ если браузер

      final info = await deviceInfo.webBrowserInfo;

      return DeviceDetails(
        id: installationId,
        name: info.product ?? '',
        vendor: info.vendor ?? '',
        osVersion: info.userAgent ?? '',
      );

      // deviceId = const Uuid().v4();
      // deviceModel = info.product ?? 'Unknown';
      // deviceBrand = info.vendor ?? 'Unknown';
      // deviceOsVersion = info.appVersion ?? '0.0.0';
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return DeviceDetails(
        id: installationId,
        name: info.model,
        vendor: 'Apple',
        osVersion: info.osRelease,
      );
    }
    // else if (Platform.isAndroid) {
    //   final info = await deviceInfo.androidInfo;
    //   deviceId = info.id;
    //   deviceModel = info.model;
    //   deviceBrand = info.brand;
    //   deviceOsVersion = info.version.release;
    // } else if (Platform.isWindows) {
    //   final info = await deviceInfo.windowsInfo;
    //   deviceId = info.deviceId;
    //   deviceModel = info.computerName;
    //   deviceBrand = info.registeredOwner;
    //   deviceOsVersion = '${info.productName} ${info.buildNumber}';
    // }

    return DeviceDetails();
  }
}
