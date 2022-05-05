import 'package:get/get.dart';

class MainLogicController extends GetxController {
  var selectedIndex = 1.obs;
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  String getTitle() {
    switch (selectedIndex.value) {
      case 0:
        return 'history'.tr;
      case 1:
        return 'home'.tr;
      case 2:
        return 'settings'.tr;
      default:
        return '';
    }
  }
}
