import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Device {
  final String id;
  final String name;
  final String vendor;
  final String osVersion;
  final String ip;
  final String applicationVersion;

  Device({
    this.id = '',
    this.name = '',
    this.vendor = '',
    this.osVersion = '',
    this.ip = '',
    this.applicationVersion = '',
  });

  static Future<Device> initialize() async {
    /// инициализируем локальное хранилище
    final sharedPreferences = await SharedPreferences.getInstance();

    /// считываем или генерируем идентификатор установки
    final installationId = sharedPreferences.getString(
          'id',
        ) ??
        const Uuid().v4();

    /// сохраняем идентификатор установки
    sharedPreferences.setString('id', installationId);

    /// инициализируем информацию о приложении
    final packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = ;
    // String buildNumber = packageInfo.buildNumber;

    /// инициализируем информацию об устройстве
    final deviceInfo = DeviceInfoPlugin();

    final ip = (await Dio().get('https://api.ipify.org/')).data.toString();

    if (kIsWeb) {
      /// ^ если браузер
      final info = await deviceInfo.webBrowserInfo;

      return Device(
        id: installationId,
        name: info.product ?? '',
        vendor: info.vendor ?? '',
        osVersion: info.userAgent ?? '',
        ip: ip,
        applicationVersion: packageInfo.version,
      );
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return Device(
        id: installationId,
        name: info.model,
        vendor: 'Apple',
        osVersion: info.osRelease,
        ip: ip,
        applicationVersion: packageInfo.version,
      );
    } else if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return Device(
        id: info.id,
        name: info.model,
        vendor: info.brand,
        osVersion: info.version.release,
        ip: ip,
        applicationVersion: packageInfo.version,
      );
    }
    // else if (Platform.isWindows) {
    //   final info = await deviceInfo.windowsInfo;
    //   deviceId = info.deviceId;
    //   deviceModel = info.computerName;
    //   deviceBrand = info.registeredOwner;
    //   deviceOsVersion = '${info.productName} ${info.buildNumber}';
    // }

    return Device();
  }
}
