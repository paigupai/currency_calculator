import 'package:currency_calculator/app/config/constants.dart';
import 'package:currency_calculator/app/data/exchange_historical_rates.dart';
import 'package:currency_calculator/app/data/exchange_rate_data.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ExchangeRateService {
  /// 為替レート取得
  Future<ExchangeRateData> fetchExchangeRateData(
      String fromCurrency, String toCurrency,
      {double amount = 1.0}) async {
    var dio = Dio();
    final response = await dio.get(Constants.frankfurterLatestRatesAPI,
        queryParameters: {
          'amount': amount,
          'from': fromCurrency,
          'to': toCurrency
        });

    Logger().i('response: ${response.data.toString()}');

    if (response.statusCode != 200) {
      Logger().w('response statusCode: ${response.statusCode}');
    }
    final exchangeRateData = ExchangeRateData.fromJson(response.data);
    return exchangeRateData;
  }

  /// 為替レート推移
  Future<ExchangeHistoricalRates> fetchExchangeHistoricalRates(
      {required String fromCurrency,
      required String toCurrency,
      required DateTime startDate,
      DateTime? endDate,
      double amount = 1.0}) async {
    var dio = Dio();
    String urlStartDate =
        '${startDate.year}-${startDate.month}-${startDate.day.toString().padLeft(2, '0')}';
    String urlEndDate = endDate == null
        ? ''
        : '${endDate.year}-${endDate.month}-${endDate.day.toString().padLeft(2, '0')}';
    final url =
        '${Constants.frankfurterExchangeHistoricalRatesAPIBase}$urlStartDate..$urlEndDate';
    final response = await dio.get(url, queryParameters: {
      'amount': amount,
      'from': fromCurrency,
      'to': toCurrency
    });

    Logger().i('response: ${response.data.toString()}');

    if (response.statusCode != 200) {
      Logger().w('response statusCode: ${response.statusCode}');
    }
    final exchangeHistoricalRates =
        ExchangeHistoricalRates.fromJson(response.data);
    return exchangeHistoricalRates;
  }
}
