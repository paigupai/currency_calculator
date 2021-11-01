import 'package:country_code_picker/country_code.dart';
import 'package:currency_calculator/app/config/country_and_exchange_rate_config.dart';

class CountryData {
  CountryData({
    this.initialCountryCode,
    this.favoriteCountryCodeList,
    this.countryFilter,
    this.onSelectedCountry,
    this.symbol,
    this.money,
  });
  String? initialCountryCode;
  List<String>? favoriteCountryCodeList;
  List<String>? countryFilter;
  CountryCode? onSelectedCountry;
  String? symbol;
  double? money;

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        initialCountryCode: json['initialCountryCode'],
        favoriteCountryCodeList:
            List<String>.from(json['favoriteCountryCodeList'].map((x) => x)),
        countryFilter: List<String>.from(json['countryFilter'].map((x) => x)),
        onSelectedCountry: CountryCode.fromJson(json['onSelectedCountry']),
        symbol: json['symbol'],
        money: json['money'],
      );

  Map<String, dynamic> toJson() => {
        'initialCountryCode': initialCountryCode,
        'favoriteCountryCodeList':
            List<dynamic>.from(favoriteCountryCodeList!.map((x) => x)),
        'countryFilter': List<dynamic>.from(countryFilter!.map((x) => x)),
        'onSelectedCountry': onSelectedCountryToJson(),
        'symbol': symbol,
        'money': money,
      };

  String? getCurrencyCode() {
    if (onSelectedCountry == null) {
      return null;
    }
    final String? countryCode = onSelectedCountry!.code;
    return CountryAndCurrencyConfig.getCurrencyCodeFromList(countryCode!);
  }

  Map<String, dynamic> onSelectedCountryToJson() {
    return {
      'name': onSelectedCountry!.name,
      'flagUri': onSelectedCountry!.flagUri,
      'code': onSelectedCountry!.code,
      'dialCode': onSelectedCountry!.dialCode,
    };
  }
}
