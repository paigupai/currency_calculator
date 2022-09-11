import 'package:get/get.dart';

class BannerAdController extends GetxController {
  // BannerAd load Status
  var adLoadStatus = false.obs;
  void updateAdLoadStatus(bool status) {
    adLoadStatus.value = status;
    update();
  }
}
