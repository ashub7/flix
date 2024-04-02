import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/app/src/main/kotlin/dev/flutter/pigeon_plugin/Messages.g.kt',
    kotlinOptions: KotlinOptions(),
    javaOut: 'android/app/src/main/java/io/flutter/plugins/Messages.java',
    javaOptions: JavaOptions(),
    swiftOut: 'ios/Runner/Messages.g.swift',
    swiftOptions: SwiftOptions(),
    dartPackageName: 'pigeon_plugin',
  ),
)

class DeviceInfoModel {
  String? name;
}


/// FLUTTER FRAMEWORK -> FLUTTER ENGINE
@HostApi()
abstract class DeviceInfoManager {
  DeviceInfoModel getDeviceInfo();
}

/// FLUTTER FRAMEWORK <- FLUTTER ENGINE
@FlutterApi()
abstract class FlutterVersionManager {
  void deviceInfo(DeviceInfoModel deviceInfoModel);
}
