import 'package:currency_calculator/app/data/exchange_rate_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:logger/logger.dart';

class ExchangeRateService {
  /// 取得汇率
  Future<ExchangeRateData?> fetchForeignExchange(
      String fromCurrency, String toCurrency,
      {double amount = 1.0}) async {
    Response response;
    ExchangeRateData exchangeRateData;
    try {
      var dio = Dio();
      response = await dio.get('https://api.frankfurter.app/latest',
          queryParameters: {
            'amount': amount,
            'from': fromCurrency,
            'to': toCurrency
          });

      Logger().i('response: ${response.data.toString()}');

      if (response.statusCode != 200) {
        Logger().w('response statusCode: ${response.statusCode}');
      }
      exchangeRateData = ExchangeRateData.fromJson(response.data);
      return exchangeRateData;
    } catch (e) {
      if (e is DioError) {
        Get.snackbar('DioError', 'response: ${e.response}message: ${e.message}',
            icon: const Icon(Icons.error_outline));
      } else {
        Get.snackbar('jsonDecodeError', 'Error: $e',
            icon: const Icon(Icons.error_outline));
      }
      Logger().e('Error: $e');
      return null;
    }
  }
}
