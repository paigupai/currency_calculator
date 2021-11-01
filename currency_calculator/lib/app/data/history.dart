import 'dart:convert';

import 'country_data.dart';

class History {
  History({
    required this.fromCountryData,
    required this.toCountryData,
    required this.rateText,
    required this.updateTime,
  });
  final CountryData? fromCountryData;
  final CountryData? toCountryData;
  final String? rateText;
  final String? updateTime;

  factory History.fromJson(Map<String, dynamic> json) => History(
        fromCountryData:
            CountryData.fromJson(jsonDecode(json['fromCountryData'])),
        toCountryData: CountryData.fromJson(jsonDecode(json['toCountryData'])),
        rateText: json['rateText'],
        updateTime: json['updateTime'],
      );

  Map<String, dynamic> toJson() {
    return {
      'fromCountryData': jsonEncode(fromCountryData!.toJson()),
      'toCountryData': jsonEncode(toCountryData!.toJson()),
      'rateText': rateText,
      'updateTime': updateTime
    };
  }
}
