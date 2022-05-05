import 'package:currency_calculator/app/screens/history/history_page.dart';
import 'package:currency_calculator/app/screens/home/home_page.dart';
import 'package:currency_calculator/app/screens/main/controllers/main_controller.dart';
import 'package:currency_calculator/app/screens/setting/setting_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static final _screen = [
    const HistoryPage(),
    const HomePage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    final MainLogicController mainController = Get.put(MainLogicController());
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Center(child: Obx(() => Text(mainController.getTitle()))),
      ),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          index: mainController.selectedIndex.value,
          items: [
            Icon(Icons.history,
                size: 30, color: Theme.of(context).primaryColorLight),
            Icon(Icons.home,
                size: 30, color: Theme.of(context).primaryColorLight),
            Icon(Icons.settings,
                size: 30, color: Theme.of(context).primaryColorLight),
          ],
          color: (Theme.of(context).appBarTheme.backgroundColor)!,
          buttonBackgroundColor: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).backgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            Logger().i(index);
            mainController.changeSelectedIndex(index);
          },
          letIndexChange: (index) => true,
        ),
      ),
      body: SafeArea(
          child: Obx(() => _screen[mainController.selectedIndex.value])),
    );
  }
}
