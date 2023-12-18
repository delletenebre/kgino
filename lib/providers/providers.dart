import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/device_details.dart';
import '../resources/krs_storage.dart';

export 'router_provider.dart';

/// провайдер хранилища
final storageProvider =
    Provider<KrsStorage>((ref) => throw UnimplementedError());

/// провайдер информации об устройстве
final deviceDetailsProvider =
    Provider<DeviceDetails>((ref) => throw UnimplementedError());
