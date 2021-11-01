import 'package:currency_calculator/app/screens/history/controllers/history_controller.dart';
import 'package:currency_calculator/app/screens/history/history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return HistoryPageView();
  }
}
