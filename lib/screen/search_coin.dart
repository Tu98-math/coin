import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '/model/coin_entity.dart';
import '/widgets/coin_item.dart';

class SearchCoin extends StatefulWidget {
  const SearchCoin({Key? key}) : super(key: key);

  @override
  State<SearchCoin> createState() => _SearchCoinState();
}

class _SearchCoinState extends State<SearchCoin> {
  TextEditingController searchController = TextEditingController();
  List<CoinEntity> fullData = [];

  List<CoinEntity> searchData = [];

  Future<void> getApi() async {
    final response = await Dio().get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=1000&page=1&sparkline=false');
    for (var json in response.data) {
      fullData.add(CoinEntity.fromJson(json));
    }
    search();
    setState(() {});
  }

  void search() {
    searchData = [];

    for (var coin in fullData) {
      if ((coin.name ?? '')
              .toUpperCase()
              .contains(searchController.text.toUpperCase()) ||
          (coin.id ?? '')
              .toUpperCase()
              .contains(searchController.text.toUpperCase())) {
        searchData.add(coin);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (_) {
              search();
              setState(() {});
            },
          ),
          Expanded(
            child: buildListCoin(),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: const Text(
          'Search Coin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      );

  Widget buildListCoin() {
    if (fullData == []) {
      return const Text('loading');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            CoinItem(coin: searchData[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 10,
        ),
        itemCount: searchData.length,
      ),
    );
  }
}
