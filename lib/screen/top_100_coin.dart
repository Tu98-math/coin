import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '/model/coin_entity.dart';
import '/widgets/coin_item.dart';

class Top100Coin extends StatefulWidget {
  const Top100Coin({Key? key}) : super(key: key);

  @override
  State<Top100Coin> createState() => _Top100CoinState();
}

class _Top100CoinState extends State<Top100Coin> {
  List<CoinEntity> data = [];

  @override
  void initState() {
    super.initState();
    getApi();
  }

  Future<void> getApi() async {
    final response = await Dio().get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false');
    // data = List.from(response.data).map((e) => CoinEntity.fromJson(e)).toList();

    for (var json in response.data) {
      data.add(CoinEntity.fromJson(json));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: const Text(
          'List 100 coin top',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      );

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
}
