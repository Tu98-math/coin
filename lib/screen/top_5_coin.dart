import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '/model/coin_entity.dart';
import '/widgets/coin_item.dart';

class Top5Coin extends StatefulWidget {
  const Top5Coin({Key? key}) : super(key: key);

  @override
  State<Top5Coin> createState() => _Top5CoinState();
}

class _Top5CoinState extends State<Top5Coin> {
  List<CoinEntity> data = [];

  Future<void> getApi() async {
    final response = await Dio().get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=false');
    for (var json in response.data) {
      data.add(CoinEntity.fromJson(json));
    }
    setState(() {});
  }

  @override
  void initState() {
    getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) =>
              CoinItem(coin: data[index]),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 10,
          ),
          itemCount: data.length,
        ),
      );

  AppBar buildAppBar() => AppBar(
        title: const Text(
          'List 5 coin top',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      );
}
