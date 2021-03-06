import 'package:currency_calculator/app/screens/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/setting_controllers.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SettingController());
    return SettingPageView();
  }
}
