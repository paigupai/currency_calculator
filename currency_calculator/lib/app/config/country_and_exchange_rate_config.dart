import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CountryAndCurrencyConfig {
  // 货币代号(ISO 4217)
  static final List<String> currencyCodeList = [
    'AUD',
    'BGN',
    'BRL',
    'CAD',
    'CHF',
    'CNY',
    'CZK',
    'EUR',
    'DKK',
    'GBP',
    'HKD',
    'HRK',
    'HUF',
    'IDR',
    'ILS',
    'INR',
    'ISK',
    'JPY',
    'KRW',
    'MXN',
    'MYR',
    'NOK',
    'NZD',
    'PHP',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'THB',
    'TRY',
    'USD',
    'ZAR',
  ];

  // 取得国家代号(ISO 3166)list
  static final List<String> countryCodeList = [
    'AU',
    'BG',
    'BR',
    'CA',
    'CH',
    'CN',
    'CZ',
    'AU',
    'DK',
    'GB',
    'HK',
    'HR',
    'HU',
    'ID',
    'IL',
    'IN',
    'IS',
    'JP',
    'KR',
    'MX',
    'MY',
    'NO',
    'NZ',
    'PH',
    'PL',
    'RO',
    'RU',
    'SE',
    'SG',
    'TH',
    'TR',
    'US',
    'ZA',
  ];
  // static Future<List<String>> getCountryCodeList() async {
  //   final List<String> countryCodeList = [];
  //
  //   for (var foreignExchange in currencyExchangeList) {
  //     List<Country>? result =
  //         await CountryProvider.getCountryByCurrencyCode(foreignExchange);
  //     print(foreignExchange);
  //     print(result.first.alpha2Code);
  //     print(result.first.name);
  //     if (result.first.alpha2Code != null) {
  //       countryCodeList.add(result.first.alpha2Code!);
  //     }
  //   }
  //   return countryCodeList;
  // }
  /// 取得countryCodeList中的CountryCode
  static String? getCountryCodeFromList(String currencyExchange) {
    for (var i = 0; i < currencyCodeList.length; i++) {
      if (currencyExchange == currencyCodeList[i]) {
        return countryCodeList[i];
      }
    }
    return null;
  }

  /// 取得currencyExchangeList中的currencyExchange
  static String? getCurrencyCodeFromList(String countryCode) {
    for (var i = 0; i < countryCodeList.length; i++) {
      if (countryCode == countryCodeList[i]) {
        return currencyCodeList[i];
      }
    }
    return null;
  }

  static List<String> getFavoriteCountryCodeList() {
    final List<String> codeList = [];
    Locale myLocale = Localizations.localeOf(Get.context!);
    codeList.add(myLocale.countryCode!);
    codeList.add('CN');
    codeList.add('JP');
    return codeList;
  }

  static String getInitialCountryCode() {
    Locale myLocale = Localizations.localeOf(Get.context!);
    return myLocale.countryCode!;
  }
}
