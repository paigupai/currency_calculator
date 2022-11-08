import 'package:country_code_picker/country_code.dart';
import 'package:currency_calculator/app/config/country_and_exchange_rate_config.dart';
import 'package:currency_calculator/app/data/country_data.dart';
import 'package:currency_calculator/app/data/exchange_historical_rates.dart';
import 'package:currency_calculator/app/data/history.dart';
import 'package:currency_calculator/app/services/exchange_rate_service.dart';
import 'package:currency_calculator/app/services/hive_db_service.dart';
import 'package:currency_calculator/app/services/rest_countries_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeLogicController extends GetxController {
  var fromCountryData = CountryData().obs;
  var toCountryData = CountryData().obs;
  var fromText = ''.obs;
  var toTextSubTitle = ''.obs;
  var updateTime = '----.--.--'.obs;
  // 為替レート推移 modelList
  var exHisRatesModelList = ExchangeHistoricalRatesModelList().obs;
  // 為替レート推移図表表示するか
  var displayExchangeHistoricalRatesChart = false.obs;
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
    try {
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
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  Future<void> initToCountryCodeData() async {
    try {
      toCountryData.value = CountryData(
          initialCountryCode: 'JP',
          favoriteCountryCodeList:
              CountryAndCurrencyConfig.getFavoriteCountryCodeList(),
          countryFilter: CountryAndCurrencyConfig.countryCodeList);
      update();
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  /// 更新from国家code
  Future<void> changeFromCountryCode(CountryCode country,
      {bool fetchMoney = true}) async {
    try {
      fromCountryData.value.onSelectedCountry = country;
      fromCountryData.value.initialCountryCode = country.code;
      final currency =
          await restCountriesService.getCurrencyCode(country.code!);
      if (currency!.symbol != null) {
        fromCountryData.value.symbol = currency.symbol!;
      }
      if (fetchMoney) await fetchToMoney(fromText.value);
      update();
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  /// 更新to国家code
  Future<void> changeToCountryCode(CountryCode country,
      {bool fetchMoney = true}) async {
    try {
      toCountryData.value.onSelectedCountry = country;
      toCountryData.value.initialCountryCode = country.code;
      final currency =
          await restCountriesService.getCurrencyCode(country.code!);
      if (currency!.symbol != null) {
        toCountryData.value.symbol = currency.symbol!;
      }
      if (fetchMoney) await fetchToMoney(fromText.value);
      update();
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  /// 更新fromMoney
  Future<void> fetchToMoney(String text) async {
    try {
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
      final exchangeRateData = await exchangeRateService.fetchExchangeRateData(
          fromCurrency!, toCurrency!,
          amount: fromCountryData.value.money!);
      toCountryData.value.money = exchangeRateData.rate;
      updateTime.value = exchangeRateData.date;
      fetchToTextSubTitle();
      saveDataToDB();
      // 為替レート推移図表表示可能クリア
      displayExchangeHistoricalRatesChart.value = false;
      update();
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  Future<void> exchangeFromAndTo() async {
    try {
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
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  Future<void> fetchToTextSubTitle() async {
    try {
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
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  Future<void> showExchangeHistoricalRatesChart(
      {required DateTime startDate,
      DateTime? endDate,
      double amount = 1.0}) async {
    try {
      final fromCurrency = fromCountryData.value.getCurrencyCode();
      final toCurrency = toCountryData.value.getCurrencyCode();
      final result = await exchangeRateService.fetchExchangeHistoricalRates(
          fromCurrency: fromCurrency!,
          toCurrency: toCurrency!,
          startDate: startDate,
          endDate: endDate,
          amount: amount);
      final List<Rate> rates = [];
      result.rates.forEach((k, v) {
        final rate = Rate(date: k, rate: v[toCurrency]!);
        rates.add(rate);
      });
      exHisRatesModelList.value = ExchangeHistoricalRatesModelList(
          amount: amount,
          from: fromCurrency,
          to: toCurrency,
          startDate: startDate,
          endDate: endDate,
          rates: rates);
      // 為替レート推移図表表示可能
      displayExchangeHistoricalRatesChart.value = true;
      update();
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  void saveDataToDB() {
    try {
      History history = History(
          fromCountryData: fromCountryData.value,
          toCountryData: toCountryData.value,
          rateText: toTextSubTitle.value,
          updateTime: updateTime.value);
      HiveDBService.saveHistory(history);
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
    }
  }

  void handleError(Object e, StackTrace stackTrace) {
    if (e is DioError) {
      Get.snackbar(e.runtimeType.toString(),
          'response: ${e.response}message: ${e.message}',
          icon: const Icon(Icons.error_outline));
    } else {
      Get.snackbar(e.runtimeType.toString(), 'Error: $e',
          icon: const Icon(Icons.error_outline));
    }
    Logger().e('Error: $e ${stackTrace.toString()}');
  }
}
