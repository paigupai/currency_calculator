import 'package:currency_calculator/app/screens/home/controllers/home_controller.dart';
import 'package:currency_calculator/app/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeLogicController());
    return const HomePageView();
  }
}
