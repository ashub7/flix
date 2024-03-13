import 'package:injectable/injectable.dart';

import '../../domain/repository/preference_repository.dart';
import '../local/data_sources/preference_data_source.dart';

@Singleton(as: PreferenceRepository)
class PreferenceRepositoryImpl extends PreferenceRepository {
  final PreferenceDataSource _preferenceDataSource;

  PreferenceRepositoryImpl(this._preferenceDataSource);

  @override
  void setInt(String key, int value) {
    _preferenceDataSource.setInt(key, value);
  }

  @override
  void setString(String key, String value) {
    _preferenceDataSource.setString(key, value);
  }

  @override
  int getInt(String key) {
    return _preferenceDataSource.getInt(key)??-1;
  }

  @override
  String? getString(String key) {
    return _preferenceDataSource.getString(key);
  }

  @override
  bool getBool(String key) {
    return _preferenceDataSource.getBool(key)?? false;
  }

  @override
  void setBool(String key, bool value) {
    _preferenceDataSource.setBool(key, value);
  }

  @override
  void clearAll() {
    _preferenceDataSource.clearAll();
  }
}
