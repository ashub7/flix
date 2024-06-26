import 'dart:async';

import 'package:flix/src/messages.g.dart';

class PigeonPlugin {
  static final DeviceInfoManager _api = DeviceInfoManager();
  static Future<String> get platformVersion async {
    DeviceInfoModel version = await _api.getDeviceInfo();
    return version.name!;
  }
}