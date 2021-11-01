import 'package:flutter/material.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('外貨リスト画面'),
        leading: GestureDetector(
          onTap: () {},
          child: const Center(
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
            child: Container(
          child: Text('この画面で外貨を選択できる'),
        )),
      ),
    );
  }
}
