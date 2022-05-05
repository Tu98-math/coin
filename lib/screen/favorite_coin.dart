import 'package:flutter/material.dart';

class FavoriteCoin extends StatefulWidget {
  const FavoriteCoin({Key? key}) : super(key: key);

  @override
  State<FavoriteCoin> createState() => _FavoriteCoinState();
}

class _FavoriteCoinState extends State<FavoriteCoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text('Favorite coin'),
        centerTitle: true,
      );
}
