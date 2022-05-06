import 'package:currency_calculator/app/config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/setting_controllers.dart';

class SettingPageView extends StatelessWidget {
  SettingPageView({Key? key}) : super(key: key);

  final SettingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final settingList = ['language'.tr, 'theme'.tr, 'about_app'.tr];
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              onTap(context, index);
            },
            child: ListTile(
              title: Text(settingList[index]),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: settingList.length,
      ),
    );
  }

  void onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Get.defaultDialog(
          title: 'language'.tr,
          content: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < _controller.languageList.length; i++)
                  ListTile(
                    title: Text(
                      _controller.languageList[i],
                    ),
                    leading: Radio(
                        value: i,
                        groupValue: _controller.selectedRadio.value,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (int? value) {
                          _controller.selectedRadio.value = value!;
                        }),
                  ),
              ],
            );
          }),
          textConfirm: 'confirm'.tr,
          textCancel: 'cancel'.tr,
          onConfirm: () {
            _controller.updateLocale();
            Get.back();
          },
          onCancel: () => Get.back(),
        );
        break;
      case 1:
        Get.defaultDialog(
          title: 'theme'.tr,
          content: Obx(() {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.dark_mode),
                  CupertinoSwitch(
                    activeColor: Theme.of(context).primaryColorLight,
                    trackColor: Theme.of(context).primaryColorDark, //OFFの色
                    value: _controller.isDarkMode.value,
                    onChanged: (value) {
                      _controller.changeTheme();
                    },
                  ),
                  const Icon(
                    Icons.wb_sunny,
                    // color: Colors.white,
                  ),
                ],
              ),
            );
          }),
        );
        break;
      case 2:
        showAboutDialog(
            context: context,
            applicationName: Constants.appName,
            applicationVersion: Constants.appVersion,
            applicationIcon: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              child: Image.asset(
                'assets/app.png',
                width: 80,
                // height: 100,
              ),
            ));
        break;
      default:
    }
  }
}
