import 'dart:ui';

import 'package:currency_calculator/app/data/settings_data.dart';
import 'package:currency_calculator/app/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var selectedRadio = 0.obs;
  var isDarkMode = (!Get.isDarkMode).obs;
  final languageList = ['简体中文', '繁體中文', '日本語', 'English'];

  @override
  void onInit() {
    super.onInit();
    getSelectedRadio();
  }

  Future<void> getSelectedRadio() async {
    final locale = await SettingService.getLocale();
    switch (locale.languageCode) {
      case 'zh':
        if (locale.countryCode == 'TW') {
          selectedRadio.value = 1;
          break;
        }
        selectedRadio.value = 0;
        break;
      case 'ja':
        selectedRadio.value = 2;
        break;
      case 'en':
        selectedRadio.value = 3;
        break;
      default:
        selectedRadio.value = 3;
    }
  }

  void updateLocale() {
    final index = selectedRadio.value;
    Locale locale;
    switch (index) {
      case 0:
        locale = const Locale('zh', 'CN');
        break;
      case 1:
        locale = const Locale('zh', 'TW');
        break;
      case 2:
        locale = const Locale('ja', 'JP');
        break;
      case 3:
        locale = const Locale('en', 'US');
        break;
      default:
        return;
    }
    final setting = SettingsData(
      language: locale.languageCode,
      countryCode: locale.countryCode,
    );
    SettingService.saveSetting(setting);
    Get.updateLocale(locale);
    update();
  }

  void changeTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    isDarkMode.value = !isDarkMode.value;
    update();
  }
}
