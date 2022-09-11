import 'package:country_code_picker/country_code.dart';
import 'package:currency_calculator/app/config/country_and_exchange_rate_config.dart';
import 'package:currency_calculator/app/data/country_data.dart';
import 'package:currency_calculator/app/data/history.dart';
import 'package:currency_calculator/app/services/exchange_rate_service.dart';
import 'package:currency_calculator/app/services/hive_db_service.dart';
import 'package:currency_calculator/app/services/rest_countries_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogicController extends GetxController {
  var fromCountryData = CountryData().obs;
  var toCountryData = CountryData().obs;
  var fromText = ''.obs;
  var toTextSubTitle = ''.obs;
  var updateTime = '----.--.--'.obs;
  ExchangeRateService exchangeRateService = ExchangeRateService();
  RestCountriesService restCountriesService = RestCountriesService();

  @override
  void onInit() {
    // 用户停止打字时1秒后调用,主要是防DDos
    debounce(fromText, (callback) => fetchToMoney(fromText.value));
    initFromCountryCodeData();
    initToCountryCodeData();
    super.onInit();
  }

  Future<void> initFromCountryCodeData() async {
    fromCountryData.value = CountryData(
        initialCountryCode: CountryAndCurrencyConfig.getInitialCountryCode(),
        favoriteCountryCodeList:
            CountryAndCurrencyConfig.getFavoriteCountryCodeList(),
        countryFilter: CountryAndCurrencyConfig.countryCodeList);
    final currency = await restCountriesService
        .getCurrencyCode(CountryAndCurrencyConfig.getInitialCountryCode());
    if (currency!.symbol != null) {
      fromCountryData.value.symbol = currency.symbol!;
    }
    update();
  }

  Future<void> initToCountryCodeData() async {
    toCountryData.value = CountryData(
        initialCountryCode: null,
        favoriteCountryCodeList:
            CountryAndCurrencyConfig.getFavoriteCountryCodeList(),
        countryFilter: CountryAndCurrencyConfig.countryCodeList);
    update();
  }

  /// 更新from国家code
  Future<void> changeFromCountryCode(CountryCode country,
      {bool fetchMoney = true}) async {
    fromCountryData.value.onSelectedCountry = country;
    fromCountryData.value.initialCountryCode = country.code;
    final currency = await restCountriesService.getCurrencyCode(country.code!);
    if (currency!.symbol != null) {
      fromCountryData.value.symbol = currency.symbol!;
    }
    if (fetchMoney) await fetchToMoney(fromText.value);

    update();
  }

  /// 更新to国家code
  Future<void> changeToCountryCode(CountryCode country,
      {bool fetchMoney = true}) async {
    toCountryData.value.onSelectedCountry = country;
    toCountryData.value.initialCountryCode = country.code;
    final currency = await restCountriesService.getCurrencyCode(country.code!);
    if (currency!.symbol != null) {
      toCountryData.value.symbol = currency.symbol!;
    }
    if (fetchMoney) await fetchToMoney(fromText.value);
    update();
  }

  /// 更新fromMoney
  Future<void> fetchToMoney(String text) async {
    if (text.isEmpty) {
      toCountryData.value.money = 0;
      update();
      return;
    }

    try {
      fromCountryData.value.money = double.parse(text);
      if (fromCountryData.value.money == 0) {
        toCountryData.value.money = 0;
        update();
        return;
      }
    } on FormatException {
      Get.snackbar('输入错误', '请输入正确的数字', icon: const Icon(Icons.error_outline));
      return;
    }
    final fromCurrency = fromCountryData.value.getCurrencyCode();
    final toCurrency = toCountryData.value.getCurrencyCode();
    final exchangeRateData = await exchangeRateService.fetchForeignExchange(
        fromCurrency!, toCurrency!,
        amount: fromCountryData.value.money!);
    if (exchangeRateData == null) {
      return;
    }
    toCountryData.value.money = exchangeRateData.rate;
    updateTime.value = exchangeRateData.date;
    fetchToTextSubTitle();
    saveDataToDB();
    update();
  }

  Future<void> exchangeFromAndTo() async {
    final tempFromCountryData = fromCountryData.value;
    final tempToCountryData = toCountryData.value;

    fromCountryData.value = toCountryData.value;
    fromCountryData.value.initialCountryCode =
        tempToCountryData.onSelectedCountry!.code;
    toCountryData.value = tempFromCountryData;
    toCountryData.value.initialCountryCode =
        tempFromCountryData.onSelectedCountry!.code;

    await fetchToMoney(fromText.value);
    update();
  }

  Future<void> fetchToTextSubTitle() async {
    if (fromCountryData.value.money == null ||
        fromCountryData.value.money == 0 ||
        toCountryData.value.money == null ||
        toCountryData.value.money == 0) {
      return;
    }

    final fromCurrency = await restCountriesService
        .getCurrencyCode(fromCountryData.value.onSelectedCountry!.code!);
    final toCurrency = await restCountriesService
        .getCurrencyCode(toCountryData.value.onSelectedCountry!.code!);
    var rate = toCountryData.value.money! / fromCountryData.value.money!;
    toTextSubTitle.value =
        '1 ${fromCurrency!.name} = ${rate.toStringAsFixed(3)} ${toCurrency!.name}';
  }

  void saveDataToDB() {
    History history = History(
        fromCountryData: fromCountryData.value,
        toCountryData: toCountryData.value,
        rateText: toTextSubTitle.value,
        updateTime: updateTime.value);
    HiveDBService.saveHistory(history);
  }
}
