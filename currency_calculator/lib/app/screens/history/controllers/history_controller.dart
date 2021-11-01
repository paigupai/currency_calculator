import 'package:currency_calculator/app/data/history.dart';
import 'package:currency_calculator/app/services/hive_db_service.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var historyList = <History>[].obs;

  @override
  void onInit() {
    fetchHistoryList();
    super.onInit();
  }

  Future<void> fetchHistoryList() async {
    historyList.value = await HiveDBService.getHistory();
    update();
  }

  Future<void> deleteHistory(int index) async {
    var newHistoryList = historyList;
    newHistoryList.removeAt(index);
    await HiveDBService.updateHistoryList(newHistoryList);
    await fetchHistoryList();
  }
}
