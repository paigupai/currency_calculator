import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'home': '主页',
          'history': '履历',
          'settings': '设定',
          'language': '语言',
          'about_app': '关于app',
          'app_name': '汇率计算器',
          'confirm': '确认',
          'cancel': '取消',
          'theme': '主题',
        },
        'zh_TW': {
          'home': '主頁',
          'history': '歷史',
          'settings': '設定',
          'language': '語言',
          'about_app': '關於app',
          'app_name': '匯率計算器',
          'confirm': '確認',
          'cancel': '取消',
          'theme': '主題',
        },
        'ja_JP': {
          'home': 'ホーム',
          'history': '履歴',
          'settings': '設定',
          'language': '言語',
          'about_app': 'アプリについて',
          'app_name': 'レート計算機',
          'confirm': '確認',
          'cancel': 'キャンセル',
          'theme': 'テーマ',
        },
        'en_US': {
          'home': 'Home',
          'history': 'History',
          'settings': 'Settings',
          'language': 'Language',
          'about_app': 'About app',
          'app_name': 'Currency Calculator',
          'confirm': 'Confirm',
          'cancel': 'Cancel',
          'theme': 'Theme',
        }
      };
}
