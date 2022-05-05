import 'package:flutter/material.dart';

class SettingsData {
  SettingsData({
    this.language,
    this.countryCode,
    this.locale,
  });
  String? language;
  String? countryCode;
  Locale? locale;

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
        language: json['language'] as String?,
        countryCode: json['countryCode'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'language': language,
        'countryCode': countryCode,
      };
}
