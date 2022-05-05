import 'package:currency_calculator/app/config/constants.dart';
import 'package:currency_calculator/app/data/rest_country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:logger/logger.dart';

class RestCountriesService {
  // 通过国家code(ISO 3166)取得RestCountry
  Future<RestCountry?> getCountryByCode(String code) async {
    Response response;
    RestCountry restCountry;
    try {
      var dio = Dio();
      response = await dio.get('${Constants.restcountriesAPI}$code');

      Logger().i('response: ${response.data.toString()}');

      if (response.statusCode != 200) {
        Logger().w('response statusCode: ${response.statusCode}');
      }
      final json = response.data as List<dynamic>;
      restCountry = RestCountry.fromJson(json.first);
      return restCountry;
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

// /// 通过国家代号(ISO 3166)取得货币代号(ISO 4217)
  Future<Currency?> getCurrencyCode(String countryCode) async {
    RestCountry? result = await getCountryByCode(countryCode);
    return result!.currencies!.currency;
  }
}
