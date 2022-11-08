import 'dart:convert';

/// 為替レート推移
class ExchangeHistoricalRates {
  ExchangeHistoricalRates({
    required this.amount,
    required this.base,
    required this.startDate,
    required this.endDate,
    required this.rates,
  });

  final double amount;
  final String base;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, Map<String, double>> rates;

  factory ExchangeHistoricalRates.fromRawJson(String str) =>
      ExchangeHistoricalRates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExchangeHistoricalRates.fromJson(Map<String, dynamic> json) =>
      ExchangeHistoricalRates(
        amount: json["amount"],
        base: json["base"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        rates: Map.from(json["rates"]).map((k, v) =>
            MapEntry<String, Map<String, double>>(
                k,
                Map.from(v)
                    .map((k, v) => MapEntry<String, double>(k, v.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "base": base,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(
            k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}

/// 為替レート推移図表用
class ExchangeHistoricalRatesModelList {
  ExchangeHistoricalRatesModelList(
      {this.amount,
      this.from,
      this.to,
      this.startDate,
      this.endDate,
      this.rates});
  final double? amount;
  // 換算元通貨
  final String? from;
  // 換算通貨
  final String? to;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Rate>? rates;
}

class Rate {
  Rate({required this.date, required this.rate});
  final String date;
  final double rate;
}
