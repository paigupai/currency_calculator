import 'dart:ui';

import 'package:currency_calculator/app/data/settings_data.dart';
import 'package:currency_calculator/app/services/hive_db_service.dart';

class SettingService {
  // getLocale
  static Future<Locale> getLocale() async {
    final setting = await HiveDBService.getSetting();
    if (setting?.language == null) {
      final locale = window.locale;
      switch (locale.languageCode) {
        case 'zh':
        case 'ja':
        case 'en':
          return locale;
        default:
          return const Locale('en', 'US');
      }
    } else {
      switch (setting?.language) {
        case 'zh':
          if (setting?.countryCode == 'TW') {
            return const Locale('zh', 'TW');
          }
          return const Locale('zh', 'CN');
        case 'ja':
          return const Locale('ja', 'JP');
        case 'en':
          return const Locale('en', 'US');
        default:
          return const Locale('en', 'US');
      }
    }
  }

  static Future<void> saveSetting(SettingsData setting) async {
    await HiveDBService.saveSetting(setting);
  }

  static Future<SettingsData?> getSetting() async {
    final setting = await HiveDBService.getSetting();
    return setting;
  }
}
