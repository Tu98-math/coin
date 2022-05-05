import 'package:flutter/material.dart';

import '/model/coin_entity.dart';

class Top100Coin extends StatefulWidget {
  const Top100Coin({Key? key}) : super(key: key);

  @override
  State<Top100Coin> createState() => _Top100CoinState();
}

class _Top100CoinState extends State<Top100Coin> {
  List<CoinEntity> fakeData = [];

  @override
  void initState() {
    for (int i = 0; i < 100; i++) {
      fakeData.add(CoinEntity());
    }
    super.initState();
  }

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
