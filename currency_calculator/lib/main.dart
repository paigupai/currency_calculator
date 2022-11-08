import 'package:currency_calculator/app/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

import 'app/config/messages_config.dart';
import 'app/config/theme.dart';
import 'app/screens/main/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  Logger().i('starting services ...');

  ///初始化
  MobileAds.instance.initialize();
  await AppConfig.init();

  Logger().i('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppColor.themeData(),
      darkTheme: AppColor.themeData(isDark: true),
      themeMode: ThemeMode.system,
      translations: Messages(),
      locale: AppConfig.getInstance().locale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: AppConfig.getInstance().isStubFlavor(),
      home: const MainPage(),
    );
  }
}
