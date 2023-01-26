# currency_calculator
currency_calculator

[getx](https://github.com/jonataslaw/getx)検証のため作ったapp  

[Build an release Android app](https://docs.flutter.dev/deployment/android)
1. keystore作りる
```
  keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

```  

2.  [project]/currency_calculator/release/にkeystoreとkey.propertiesを入れる  
3.  リリース用のlib/env_config.dart_prodを作る

[Google Play](https://play.google.com/store/apps/details?id=com.paigu.currencyConverter)
