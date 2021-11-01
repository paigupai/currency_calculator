enum FlagSize { w20, w40, w80, w160, w320, w640, w1280, w2560 }

class FlagConfig {
  // https://flagpedia.net/download/api 参考
  static String flagCDN = 'https://flagcdn.com/';
  // 取得FlagImageURL
  String getFlagImageURLFromCountryCode(String countryCode,
      {FlagSize flagSize = FlagSize.w160}) {
    return '$flagCDN${flagSize.toString()}/$countryCode.png';
  }
}
