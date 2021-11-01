import 'package:currency_calculator/app/data/history.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class HiveDBService {
  static const hiveBox = 'hiveBox';
  static const settingBox = 'settingBox';
  static const historyListKey = 'historyList';

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
      await box.put(historyListKey, listData);
      await box.close();
      return;
    }
    historyListData.add(history.toJson());
    await box.put(historyListKey, historyListData);
    await box.close();
  }

  /// 保存history
  static Future<void> updateHistoryList(List<History> list) async {
    var box = await Hive.openBox(hiveBox);
    List<Map<String, dynamic>> listData = list.map((e) => e.toJson()).toList();
    await box.put(historyListKey, listData);
    await box.close();
    return;
  }

  /// 取得history
  static Future<List<History>> getHistory() async {
    List<History> historyList = [];
    var box = await Hive.openBox(hiveBox);

    List<dynamic> historyListData = box.get(historyListKey);
    for (var historyData in historyListData) {
      final json = Map<String, dynamic>.from(historyData);
      History history = History.fromJson(json);
      historyList.add(history);
    }
    await box.close();
    return historyList;
  }
}
