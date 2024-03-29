import 'package:flutter/material.dart';

// Colors
class CustomColor {
  static const kAccentLightColor = Color(0xFFB3BFD7);
}

class Constants {
  // Frankfurter是一个开源的API，用于获取欧洲中央银行公布的当前和历史外汇汇率。
  static const String frankfurterLatestRatesAPI =
      'https://api.frankfurter.app/latest';
  static const String frankfurterExchangeHistoricalRatesAPIBase =
      'https://api.frankfurter.app/';
  // Get information about countries via a RESTful API.
  static const String restcountriesAPI = 'https://restcountries.com/v3/alpha/';
}
