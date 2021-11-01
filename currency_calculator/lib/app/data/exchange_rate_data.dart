class ExchangeRateData {
  ExchangeRateData(this.fromCurrencyCode, this.toCurrencyCode, this.rate,
      this.amount, this.date);

  ExchangeRateData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return;
    }

    if (json['base'] != null) {
      fromCurrencyCode = json['base'];
    }

    if (json['rates'] != null) {
      Map<String, dynamic> rates = json['rates'] as Map<String, dynamic>;
      Iterable<String> keys = rates.keys;
      toCurrencyCode = keys.first;
      if (rates[toCurrencyCode] is int) {
        rate = rates[toCurrencyCode].toDouble();
      } else {
        rate = rates[toCurrencyCode];
      }
    }

    if (json['amount'] != null) {
      if (json['amount'] is int) {
        amount = json['amount'].toDouble();
      } else {
        amount = json['amount'];
      }
    }

    if (json['date'] != null) {
      date = json['date'];
    }
  }

  late final String fromCurrencyCode;
  late final String toCurrencyCode;
  late final double rate;
  late final double amount;
  late final String date;
}
