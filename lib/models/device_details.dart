import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_details.freezed.dart';

@unfreezed
class DeviceDetails with _$DeviceDetails {
  factory DeviceDetails({
    @Default('') final String id,
    @Default('') final String name,
    @Default('') final String vendor,

  }) = _DeviceDetails;
  
}
