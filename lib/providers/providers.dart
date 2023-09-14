import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/device_details.dart';
import '../resources/krs_storage.dart';

export 'app_locale.dart';
export 'app_theme.dart';
export 'auth_provider.dart';
export 'card_details.dart';
export 'router_provider.dart';

/// провайдер хранилища
final storageProvider =
    Provider<KrsStorage>((ref) => throw UnimplementedError());

/// провайдер информации об устройстве
final deviceDetailsProvider =
    Provider<DeviceDetails>((ref) => throw UnimplementedError());

/// провайдер поискового запроса
final searchProvider =
    Provider<TextEditingController>((ref) => TextEditingController());
