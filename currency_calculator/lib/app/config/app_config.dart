import 'dart:ui';

import 'package:currency_calculator/app/data/settings_data.dart';
import 'package:currency_calculator/app/services/hive_db_service.dart';
import 'package:currency_calculator/app/services/setting_service.dart';
import 'package:currency_calculator/env_config.dart';
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
  AppConfig._internal();

  static init() async {
    _instance = AppConfig._internal();
    await _instance.getPackageInfo();
    await HiveDBService.initDB();
    // 設定取得
    var setting = await SettingService.getSetting();
    if (setting != null) {
      if (setting.locale != null) {
        _instance.locale = setting.locale!;
      } else {
        _instance.locale = _instance.getShowLocale();
      }
    } else {
      // 初回起動
      _instance.locale = _instance.getShowLocale();
      setting = SettingsData(
        language: _instance.locale.languageCode,
        countryCode: _instance.locale.countryCode,
      );
      await SettingService.saveSetting(setting);
    }
  }

  static AppConfig getInstance() {
    return _instance;
  }

  late ConfigType configType;

  /// アプリ名
  String appName = 'app_name'.tr;
  String appVersion = '1.0.0';
  late Locale locale;

  String gmsAdUnitID() {
    switch (configType) {
      case ConfigType.stub:
        return 'ca-app-pub-3940256099942544/6300978111';
      case ConfigType.prod:
        // リリース時にはここを変更する
        return bannerAdmobAppId;
    }
  }

  // app情報取得
  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    appVersion = packageInfo.version;
    // packageNameから環境を判定(stub or prod)
    if (packageInfo.packageName.contains('stub')) {
      configType = ConfigType.stub;
    } else {
      configType = ConfigType.prod;
    }
  }

  //　表示する言語を取得
  Locale getShowLocale() {
    // システムの言語設定を取得
    final locale = window.locale;
    // 中国語日本語英語以外は英語にする
    switch (locale.languageCode) {
      case 'zh':
      case 'ja':
      case 'en':
        return locale;
      default:
        return const Locale('en', 'US');
    }
  }

  bool isStubFlavor() {
    if (configType == ConfigType.prod) {
      return false;
    }
    return true;
  }
}
