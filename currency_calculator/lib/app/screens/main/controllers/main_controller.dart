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
        return '履历';
      case 1:
        return '主页';
      case 2:
        return '设定';
      default:
        return '';
    }
  }
}
