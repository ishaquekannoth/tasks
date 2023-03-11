import 'package:package_info_plus/package_info_plus.dart';
import 'package:task/domain/entities/firebase/remote_config.dart';

class RemoteConfigUtils {
  final String _serverString =
      RemoteConfigServices.fetchServerStringValue("updateMessage");
  final bool _hasUpdate =
      RemoteConfigServices.fetchServerboolValue("hasUpdate");
  final String _appVersion =
      RemoteConfigServices.fetchServerStringValue("appVersion");
  // final String _productId =
  //     RemoteConfigServices.fetchServerStringValue("productId");
  static bool _showBanner = false;
  final String _notificationBody =
      RemoteConfigServices.fetchServerStringValue("notificationBody");
  final String _notificationTitle =
      RemoteConfigServices.fetchServerStringValue("notificationTitle");
  checkPackageVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    if (_hasUpdate && info.version != _appVersion) {
      _showBanner = true;
    }
  }

  String get getServerString => _serverString;
  bool get getHasUpdate => _hasUpdate;
  String get getAppVersion => _appVersion;
  //String get productId => _productId;
  bool get showBanner => _showBanner;
  String get notificationBody => _notificationBody;
  String get notificationTitle => _notificationTitle;
}
