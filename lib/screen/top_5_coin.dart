import 'package:flutter/material.dart';

class Top5Coin extends StatelessWidget {
  const Top5Coin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text('Top 5 coin'),
        centerTitle: true,
      );
}
