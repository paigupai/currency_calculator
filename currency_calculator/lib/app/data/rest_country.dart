class RestCountry {
  RestCountry({
    this.name,
    this.cca2,
    this.ccn3,
    this.cca3,
    this.cioc,
    this.currencies,
    this.translations,
    this.flag,
    this.flags,
  });

  final Name? name;
  final String? cca2;
  final String? ccn3;
  final String? cca3;
  final String? cioc;
  final Currencies? currencies;
  final Map<String, Translation>? translations;
  final String? flag;
  final List<String>? flags;

  factory RestCountry.fromJson(Map<String, dynamic> json) => RestCountry(
        name: Name.fromJson(json["name"]),
        cca2: json["cca2"],
        ccn3: json["ccn3"],
        cca3: json["cca3"],
        cioc: json["cioc"],
        currencies: Currencies.fromJson(json["currencies"]),
        translations: Map.from(json["translations"]).map((k, v) =>
            MapEntry<String, Translation>(k, Translation.fromJson(v))),
        flag: json["flag"],
        flags: List<String>.from(json["flags"].map((x) => x)),
      );
}

class Currencies {
  Currencies({
    this.code,
    this.currency,
  });
  late final String? code;
  late final Currency? currency;

  factory Currencies.fromJson(Map<String, dynamic> json) {
    final keys = json.keys;
    return Currencies(
      code: keys.first,
      currency: Currency.fromJson(json[keys.first]),
    );
  }
}

class Currency {
  Currency({
    this.name,
    this.symbol,
  });

  final String? name;
  final String? symbol;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
      );
}

class Name {
  Name({
    this.common,
    this.official,
    this.nativeName,
  });

  final String? common;
  final String? official;
  final NativeName? nativeName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
        nativeName: NativeName.fromJson(json["nativeName"]),
      );
}

class NativeName {
  NativeName({
    this.code,
    this.translation,
  });
  final String? code;
  final Translation? translation;

  factory NativeName.fromJson(Map<String, dynamic> json) {
    final keys = json.keys;
    return NativeName(
      code: keys.first,
      translation: Translation.fromJson(json[keys.first]),
    );
  }
}

class Translation {
  Translation({
    this.official,
    this.common,
  });

  final String? official;
  final String? common;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        official: json["official"],
        common: json["common"],
      );
}
