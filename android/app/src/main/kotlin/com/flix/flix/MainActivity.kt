package com.flix.flix

import dev.flutter.pigeon_plugin.pigeon_host.DeviceInfoProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(DeviceInfoProvider())
        super.configureFlutterEngine(flutterEngine)
    }

}
