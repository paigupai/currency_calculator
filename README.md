# currency_calculator
currency_calculator

[Build an release Android app](https://docs.flutter.dev/deployment/android)
1. keystore作りる
```
  keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

```  

2.  [project]/currency_calculator/release/にkeystoreとkey.propertiesを入れる  
3.  リリース用のlib/env_config.dart_prodを作る
