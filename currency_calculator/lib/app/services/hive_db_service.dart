import 'package:currency_calculator/app/data/history.dart';
import 'package:currency_calculator/app/data/settings_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class HiveDBService {
  static const hiveBox = 'hiveBox';
  static const settingBox = 'settingBox';
  static const historyListKey = 'historyList';
  static const settingsKey = 'settings';

  static Future<void> initDB() async {
    await Hive.initFlutter();
  }

  /// 保存history
  static Future<void> saveHistory(History history) async {
    var box = await Hive.openBox(hiveBox);
    var historyListData = box.get(historyListKey);
    Logger().i(history.toJson());
    if (historyListData == null) {
      List<Map<String, dynamic>> listData = [history.toJson()];
      await saveHiveBox(historyListKey, listData, box: box);
      return;
    }
    historyListData.add(history.toJson());
    await saveHiveBox(historyListKey, historyListData, box: box);
  }

  /// 保存history
  static Future<void> updateHistoryList(List<History> list) async {
    var box = await Hive.openBox(hiveBox);
    List<Map<String, dynamic>> listData = list.map((e) => e.toJson()).toList();
    await saveHiveBox(historyListKey, listData, box: box);
    return;
  }

  /// 取得history
  static Future<List<History>> getHistory() async {
    List<History> historyList = [];
    var box = await Hive.openBox(hiveBox);

    final historyListData = box.get(historyListKey);
    if (historyListData == null) {
      return historyList;
    }
    for (var historyData in historyListData) {
      final json = Map<String, dynamic>.from(historyData);
      History history = History.fromJson(json);
      historyList.add(history);
    }
    await box.close();
    return historyList;
  }

  // 保存HiveBox
  static Future<void> saveHiveBox(String key, dynamic value,
      {required Box box}) async {
    await box.put(key, value);
    await box.close();
  }

  /// 保存SettingsData
  static Future<void> saveSetting(SettingsData data) async {
    var box = await Hive.openBox(settingBox);
    await saveHiveBox(settingsKey, data.toJson(), box: box);
    return;
  }

  /// 取得SettingsData
  static Future<SettingsData?> getSetting() async {
    var box = await Hive.openBox(settingBox);
    var settingData = box.get(settingsKey);
    if (settingData == null) {
      return null;
    }
    return SettingsData.fromJson(Map<String, dynamic>.from(settingData));
  }
}
