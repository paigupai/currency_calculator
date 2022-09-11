import 'package:currency_calculator/app/common/banner_ad/banner_ad_view.dart';
import 'package:flutter/cupertino.dart';

class BottomBannerAdView extends StatelessWidget {
  const BottomBannerAdView({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: BannerAdView(),
            )),
      ],
    );
  }
}
