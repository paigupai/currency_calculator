import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:currency_calculator/app/data/exchange_historical_rates.dart';
import 'package:currency_calculator/app/screens/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///　為替レート推移図表
class ExchangeHistoricalRatesChart extends StatelessWidget {
  const ExchangeHistoricalRatesChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeLogicController homeLogicController = Get.find();
    return Obx(() {
      if (homeLogicController.displayExchangeHistoricalRatesChart.value) {
        return brokenLineChart(
            context, homeLogicController.exHisRatesModelList.value);
      }
      // SubTitleの戻り値
      // 例:1 United States dollar = 1.551 Australian dollar
      if (homeLogicController.toTextSubTitle.value.isEmpty) {
        return Container();
      }
      return Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // デフォルトは一ヶ月前
            final oneMonthAgo = DateTime.now().add(const Duration(days: -30));
            homeLogicController.showExchangeHistoricalRatesChart(
                startDate: oneMonthAgo);
          },
          child: Text('view_chart'.tr),
        ),
      );
    });
  }

  Widget brokenLineChart(context, ExchangeHistoricalRatesModelList modelList) {
    if (modelList.rates == null) return Container();
    final List<Rate> retes = modelList.rates!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        BrnBrokenLine(
          showPointDashLine: true,
          yHintLineOffset: 20,
          isTipWindowAutoDismiss: false,
          lines: [
            BrnPointsLine(
              isShowPointText: true,
              isShowXDial: true,
              lineWidth: 3,
              pointRadius: 4,
              isShowPoint: true,
              isCurve: true,
              points: _linePoints(retes),
              shaderColors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Theme.of(context).primaryColor.withOpacity(0.01)
              ],
              lineColor: Theme.of(context).primaryColor,
            )
          ],
          size: Size(MediaQuery.of(context).size.width * 2,
              MediaQuery.of(context).size.height / 5 * 2),
          isShowXHintLine: true,
          xDialValues: _getXDialValues(retes),
          xDialMin: 0,
          xDialMax: _getXDialValues(retes).length.toDouble(),
          yDialValues: _getYDialValues(retes),
          yDialMin: _getMinValue(retes),
          yDialMax: _getMaxValue(retes),
          isHintLineSolid: false,
          isShowYDialText: true,
        ),
      ],
    );
  }

  List<BrnPointData> _linePoints(List<Rate> modelList) {
    return modelList
        .map((_) => BrnPointData(
            pointText: _.rate.toString(),
            x: modelList.indexOf(_).toDouble(),
            y: _.rate,
            lineTouchData: BrnLineTouchData(
                tipWindowSize: const Size(60, 40),
                onTouch: () {
                  return _.rate.toString();
                })))
        .toList();
  }

  List<BrnDialItem> _getYDialValues(List<Rate> modelList) {
    double min = _getMinValue(modelList);
    double max = _getMaxValue(modelList);
    double dValue = (max - min) / 10;
    List<BrnDialItem> yDialValue = [];
    for (int index = 0; index <= 10; index++) {
      yDialValue.add(BrnDialItem(
        dialText: '${(min + index * dValue).ceil()}',
        dialTextStyle:
            const TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
        value: (min + index * dValue).ceilToDouble(),
      ));
    }
    yDialValue.add(BrnDialItem(
      dialText: '4.5',
      dialTextStyle: const TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
      value: 4.5,
    ));
    return yDialValue;
  }

  double _getMinValue(List<Rate> modelList) {
    double minValue = modelList[0].rate;
    for (Rate rate in modelList) {
      minValue = min(rate.rate, minValue);
    }
    return minValue;
  }

  double _getMaxValue(List<Rate> modelList) {
    double maxValue = modelList[0].rate;
    for (Rate rate in modelList) {
      maxValue = max(rate.rate, maxValue);
    }
    return maxValue;
  }

  List<BrnDialItem> _getXDialValues(List<Rate> modelList) {
    List<BrnDialItem> xDialValue = [];
    for (int index = 0; index < modelList.length; index++) {
      xDialValue.add(BrnDialItem(
        dialText: modelList[index].date.substring(5),
        dialTextStyle:
            const TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
        value: index.toDouble(),
      ));
    }
    return xDialValue;
  }
}
