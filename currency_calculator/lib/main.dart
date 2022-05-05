import 'dart:ui';

import 'package:currency_calculator/app/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';

import 'app/config/constants.dart';
import 'app/config/messages_config.dart';
import 'app/config/theme.dart';
import 'app/screens/main/main_page.dart';
import 'app/services/hive_db_service.dart';

Future<void> main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  Logger().i('starting services ...');

  ///初始化
  await HiveDBService.initDB();
  // 取出保存的设定
  final setting = await SettingService.getSetting();
  if (setting != null) {
    Constants.locale = setting.locale!;
  }

  Logger().i('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData(),
      darkTheme: themeData(isDark: true),
      themeMode: ThemeMode.system,
      translations: Messages(),
      locale: Constants.locale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
