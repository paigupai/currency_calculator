import 'package:currency_calculator/app/common/banner_ad/banner_ad_controller.dart';
import 'package:currency_calculator/app/config/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

class BannerAdView extends StatefulWidget {
  const BannerAdView({Key? key}) : super(key: key);

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  late BannerAdController controller;
  late BannerAd bannerAd;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BannerAdController());
    bannerAd = BannerAd(
      adUnitId: AppConfig.getInstance().gmsAdUnitID(),
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          Logger().i('Ad loaded.');
          controller.updateAdLoadStatus(true);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          Logger().i('Ad load Failed.${error.message}');
          controller.updateAdLoadStatus(false);
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerAdController>(
        init: controller,
        builder: (controller) {
          if (controller.adLoadStatus.value == false) {
            return Container();
          }
          return SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: Center(child: AdWidget(ad: bannerAd)));
        });
  }
}
