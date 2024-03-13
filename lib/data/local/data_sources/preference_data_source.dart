import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferenceDataSource {
  void setString(String key, String value);
  void setInt(String key, int value);
  String? getString(String key);
  int? getInt(String key);
  void setBool(String key, bool value);
  bool? getBool(String key);
  void clearAll();
}

@Singleton(as: PreferenceDataSource)
class PreferenceDataSourceImpl extends PreferenceDataSource {
  final SharedPreferences _sharedP;

  PreferenceDataSourceImpl(this._sharedP);

  @override
  void setInt(String key, int value) {
    _sharedP.setInt(key, value);
  }

  @override
  void setString(String key, String value) {
    _sharedP.setString(key, value);
  }

  @override
  int? getInt(String key) {
    return _sharedP.getInt(key);
  }

  @override
  String? getString(String key) {
    return _sharedP.getString(key);
  }

  @override
  bool? getBool(String key) {
    return _sharedP.getBool(key);
  }

  @override
  void setBool(String key, bool value) {
    _sharedP.setBool(key, value);
  }

  @override
  void clearAll() {
    _sharedP.clear();
  }
}
