import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../model/coin_entity.dart';
import '../widgets/coin_item.dart';

class FavoriteCoin extends StatefulWidget {
  const FavoriteCoin({Key? key}) : super(key: key);

  @override
  State<FavoriteCoin> createState() => _FavoriteCoinState();
}

class _FavoriteCoinState extends State<FavoriteCoin> {
  List<CoinEntity> favoriteData = [];
  final box = GetStorage();
  List<String> favorite = [];

  Future<void> getApi() async {
    final response = await Dio().get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false');
    for (var json in response.data) {
      if (favorite.indexWhere((element) => element == json['id']) >= 0) {
        favoriteData.add(CoinEntity.fromJson(json));
      }
    }
    setState(() {});
  }

  void readFavorite() {
    var read = box.read('favorite');
    if (read != null) {
      setState(() {
        favorite = read;
      });
    } else {
      box.write('favorite', {});
    }
  }

  @override
  void initState() {
    super.initState();
    readFavorite();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: buildListCoin(),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: const Text(
          'Favorite Coin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      );

  Widget buildListCoin() {
    if (favoriteData == []) {
      return const Text('loading');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            CoinItem(coin: favoriteData[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 10,
        ),
        itemCount: favoriteData.length,
      ),
    );
  }
}
