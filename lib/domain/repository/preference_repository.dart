abstract class PreferenceRepository {
  void setString(String key, String value);
  void setInt(String key, int value);
  String? getString(String key);
  int getInt(String key);
  void setBool(String key, bool value);
  bool getBool(String key);
  void clearAll();
}
