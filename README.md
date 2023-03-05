# currency_calculator
currency_calculator
A flutter app for calculating exchange rates. 

The state management is done using the getx.

debug mode requires build flavor: stub to start.

Store：
[Google Play](https://play.google.com/store/apps/details?id=com.paigu.currencyConverter)

[getx](https://github.com/jonataslaw/getx)検証のため作った為替レートapp  

debugモード起動にはbuild flavor：stubにする必要ある
<img width="721" alt="スクリーンショット 2023-03-05 23 44 44" src="https://user-images.githubusercontent.com/44311361/222967446-afe278a6-f193-46f3-b362-d672aed619a1.png">

[Build an release Android app](https://docs.flutter.dev/deployment/android)

1.　release状態でbuildにはkeystoreが必要
```
  keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

```  

2.  [project]/currency_calculator/release/にkeystoreとkey.propertiesを入れる  
3.  リリース用のlib/env_config.dart_prodを作る


