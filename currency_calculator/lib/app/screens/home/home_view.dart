import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:currency_calculator/app/common/banner_ad/bottom_banner_ad_view.dart';
import 'package:currency_calculator/app/common/common.dart';
import 'package:currency_calculator/app/common/x_number_text_input_formatter.dart';
import 'package:currency_calculator/app/config/constants.dart';
import 'package:currency_calculator/app/screens/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late HomeLogicController homeLogicController;
  late TextEditingController _textController;
  late FocusNode _textFocusNode;

  @override
  void initState() {
    homeLogicController = Get.find();
    _textController = TextEditingController();
    _textFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBannerAdView(
      child: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                fromCurrencyDescriptiveText(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Transform.rotate(
                      angle: pi / 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(
                            side: BorderSide(
                              color: Colors.transparent,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onPressed: () {
                          homeLogicController.exchangeFromAndTo();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.compare_arrows,
                            size: 40,
                          ),
                        ),
                      )),
                ),
                toCurrencyDescriptiveText(),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, bottom: 0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.refresh),
                      const SizedBox(
                        width: 12,
                      ),
                      Obx(() => Text(homeLogicController.updateTime.value)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Obx(() {
                      return Text(homeLogicController.toTextSubTitle.value);
                    }),
                  ),
                ),
                // 增加可点击区域
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fromCurrencyDescriptiveText() {
    return GetBuilder<HomeLogicController>(
        init: homeLogicController,
        builder: (controller) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CountryCodePicker(
                      onChanged: (country) {
                        Logger().i('countryCode onChanged ${country.name}');
                        controller.changeFromCountryCode(country);
                      },
                      onInit: (country) {
                        Logger().i('countryCode onChanged ${country!.name}');
                        controller.changeFromCountryCode(country,
                            fetchMoney: false);
                      },
                      initialSelection:
                          controller.fromCountryData.value.initialCountryCode,
                      flagWidth: 50,
                      hideMainText: true,
                      showCountryOnly: true,
                      showOnlyCountryWhenClosed: true,
                      favorite: controller
                              .fromCountryData.value.favoriteCountryCodeList ??
                          [],
                      countryFilter:
                          controller.fromCountryData.value.countryFilter,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                    ),
                  ],
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      _textFocusNode.requestFocus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 150,
                            child: TextField(
                              controller: _textController,
                              focusNode: _textFocusNode,
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // 入力ボックスの内余白
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText:
                                      '${controller.fromCountryData.value.symbol ?? ''}${controller.fromCountryData.value.money ?? '0.0'}'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]")),
                                XNumberTextInputFormatter(
                                    maxDecimalLength: 15, maxIntegerLength: 15),
                              ],
                              onChanged: (text) {
                                Logger().i(text);
                                controller.fromText.value = text;
                              },
                            )),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 2,
                            height: 30,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: CustomColor.kAccentLightColor),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.calculate,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget toCurrencyDescriptiveText() {
    return GetBuilder<HomeLogicController>(
        init: homeLogicController,
        builder: (controller) {
          return Card(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountryCodePicker(
                        onChanged: (country) {
                          Logger().i('countryCode onChanged ${country.name}');
                          controller.changeToCountryCode(country);
                        },
                        onInit: (country) {
                          Logger().i('countryCode onChanged ${country!.name}');
                          controller.changeToCountryCode(country,
                              fetchMoney: false);
                        },
                        initialSelection:
                            controller.toCountryData.value.initialCountryCode,
                        flagWidth: 50,
                        hideMainText: true,
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        favorite: controller
                                .toCountryData.value.favoriteCountryCodeList ??
                            [],
                        countryFilter:
                            controller.toCountryData.value.countryFilter,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                      ),
                    ],
                  ),
                  const Spacer(),
                  AnimatedFlipCounter(
                    duration: const Duration(milliseconds: 500),
                    prefix: controller.toCountryData.value.symbol ?? '',
                    value: controller.toCountryData.value.money ?? 0,
                    fractionDigits: Common.getFractionDigits(
                        controller.toCountryData.value.money ?? 0),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          );
        });
  }
}
