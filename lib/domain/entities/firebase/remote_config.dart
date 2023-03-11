import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigServices {
  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;
  static Future<FirebaseRemoteConfig> fetchRemoteConfigData() async {
    try {
      _remoteConfig.setDefaults({
        "appVersion": "",
        "hasUpdate": false,
        "updateMessage": "",
        "productId": "1",
        "notificationBody":"",
        "notificationTitle":""
      });
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero));
      await _remoteConfig.fetchAndActivate();
      return _remoteConfig;
    } catch (e) {
      return _remoteConfig;
    }
  }

  FirebaseRemoteConfig get() => _remoteConfig;
  static String fetchServerStringValue(String key) {
    return _remoteConfig.getString(key);
  }

  static double fetchServerNumValue(String key) {
    return _remoteConfig.getDouble(key);
  }

  static bool fetchServerboolValue(String key) {
    return _remoteConfig.getBool(key);
  }
}
