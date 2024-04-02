package dev.flutter.pigeon_plugin.pigeon_host
import io.flutter.embedding.engine.plugins.FlutterPlugin
import DeviceInfoManager
import DeviceInfoModel

class DeviceInfoProvider : FlutterPlugin, DeviceInfoManager{
    override fun getDeviceInfo(): DeviceInfoModel {
       return  DeviceInfoModel("Android");
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }
}