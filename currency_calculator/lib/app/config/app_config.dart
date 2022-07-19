import 'dart:ui';

import 'package:currency_calculator/app/services/hive_db_service.dart';
import 'package:currency_calculator/app/services/setting_service.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

///
/// アプリ設定
///

enum ConfigType {
  stub,
  prod,
}

class AppConfig {
  static late AppConfig _instance;
  AppConfig._internal(this.configType);

  static init(ConfigType configType) async {
    _instance = AppConfig._internal(configType);
    await _instance.getPackageInfo();
    await HiveDBService.initDB();
    // 取出保存的设定
    final setting = await SettingService.getSetting();
    if (setting != null && setting.locale != null) {
      _instance.locale = setting.locale!;
    }
  }

  static AppConfig getInstance() {
    return _instance;
  }

  ConfigType configType;

  /// アプリ名
  String appName = 'app_name'.tr;
  String appVersion = '1.0.0';
  Locale locale = const Locale('en', 'US');

  String gmsAdUnitID() {
    switch (configType) {
      case ConfigType.stub:
        return 'ca-app-pub-3940256099942544/6300978111';
      case ConfigType.prod:
        return 'ca-app-pub-3940256099942544/6300978111';
    }
  }

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    appVersion = packageInfo.version;
  }
}
