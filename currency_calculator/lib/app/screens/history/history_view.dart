import 'package:currency_calculator/app/data/country_data.dart';
import 'package:currency_calculator/app/data/history.dart';
import 'package:currency_calculator/app/screens/history/controllers/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPageView extends StatelessWidget {
  HistoryPageView({Key? key}) : super(key: key);

  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    historyController.fetchHistoryList();
    return Obx(
      () => ListView.builder(
        itemCount: historyController.historyList.length,
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (BuildContext context, int index) {
          History history = historyController.historyList[index];
          CountryData fromCountryData = history.fromCountryData!;
          CountryData toCountryData = history.toCountryData!;
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              historyController.deleteHistory(index);
            },
            background: Container(
              color: Colors.red,
              child: const ListTile(
                trailing: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      fromCountryData.onSelectedCountry!.flagUri!,
                      package: 'country_code_picker',
                      width: 20,
                    ),
                    Text(
                        '${fromCountryData.symbol}${fromCountryData.money} = '),
                    Image.asset(
                      toCountryData.onSelectedCountry!.flagUri!,
                      package: 'country_code_picker',
                      width: 20,
                    ),
                    Text('${toCountryData.symbol}${toCountryData.money}'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(history.rateText ?? ''),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(history.updateTime ?? ''),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  height: 1,
                ),
              ],
            ),
          );
        },
      ),
    );

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        if (index == (10 - 1)) {
          return const Divider(
            height: 1,
          );
        }
        return ListTile(
          title: Text('履歴'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: 10,
    );
  }
}
