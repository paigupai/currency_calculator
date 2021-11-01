import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';

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
  Logger().i('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: themeData(),
      // darkTheme: darkThemeData(),
      // themeMode: ThemeMode.system,
      home: const MainPage(),
    );
  }
}
