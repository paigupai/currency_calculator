import 'package:flutter/material.dart';

class SettingPageView extends StatelessWidget {
  const SettingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        if (index == (100 - 1)) {
          return const Divider(
            height: 1,
          );
        }
        return InkWell(
          onTap: () {
            showAboutDialog(context: context);
          },
          child: const ListTile(
            title: Text('設定'),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: 100,
    );
  }
}
