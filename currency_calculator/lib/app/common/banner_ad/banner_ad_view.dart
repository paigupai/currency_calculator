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
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerAdController());
    final adSize =
        AdSize(width: MediaQuery.of(context).size.width.toInt(), height: 60);
    BannerAd? _bannerAd = BannerAd(
      adUnitId: AppConfig.getInstance().gmsAdUnitID(),
      size: adSize,
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

    return GetBuilder<BannerAdController>(
        init: controller,
        builder: (controller) {
          if (controller.adLoadStatus.value == false) {
            return Container();
          }
          return SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: Center(child: AdWidget(ad: _bannerAd)));
        });
  }
}
