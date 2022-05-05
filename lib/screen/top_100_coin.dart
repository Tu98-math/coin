import 'package:flutter/material.dart';

class Top100Coin extends StatelessWidget {
  const Top100Coin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text('Top 100 coin'),
        centerTitle: true,
      );

  Widget buildBody() => Container();
}
