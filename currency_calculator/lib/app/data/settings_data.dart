import 'package:flutter/material.dart';

class SettingsData {
  SettingsData({
    @required this.language,
    @required this.countryCode,
    this.locale,
  });
  String? language;
  String? countryCode;
  Locale? locale;

  SettingsData.fromJson(Map<String, dynamic> json) {
    if (json['language'] != null) {
      language = json['language'];
    }
    if (json['countryCode'] != null) {
      countryCode = json['countryCode'];
    }
    if (language != null && countryCode != null) {
      locale = Locale(language!, countryCode!);
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'language': language,
        'countryCode': countryCode,
      };
}
