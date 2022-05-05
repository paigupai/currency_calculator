import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Colors
class CustomColor {
  static const kAccentLightColor = Color(0xFFB3BFD7);
}

class Constants {
  // Frankfurter是一个开源的API，用于获取欧洲中央银行公布的当前和历史外汇汇率。
  static const String frankfurterAPI = 'https://api.frankfurter.app/latest';
  // Get information about countries via a RESTful API.
  static const String restcountriesAPI = 'https://restcountries.com/v3/alpha/';
  static String appName = 'app_name'.tr;
  static const String appVersion = '0.9.0';
  static Locale locale = const Locale('en', 'US');
}
