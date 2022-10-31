import 'package:currency_calculator/app/common/banner_ad/bottom_banner_ad_view.dart';
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
    return BottomBannerAdView(
      child: Obx(
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
                    height: 16,
                  ),
                  // 数字が長すぎるを防ぐ
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Image.asset(
                        fromCountryData.onSelectedCountry!.flagUri!,
                        package: 'country_code_picker',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                          '${fromCountryData.symbol}${fromCountryData.money} = '),
                      Image.asset(
                        toCountryData.onSelectedCountry!.flagUri!,
                        package: 'country_code_picker',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('${toCountryData.symbol}${toCountryData.money}'),
                    ],
                  ),
                  history.rateText!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(history.rateText ?? ''),
                        )
                      : const SizedBox(),
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
                  // 最後の項目に広告を被せないため
                  historyController.historyList.length == (index + 1)
                      ? const SizedBox(
                          height: 80,
                        )
                      : Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
