import 'package:coin/screen/favorite_coin.dart';
import 'package:coin/screen/search_coin.dart';
import 'package:coin/screen/top_100_coin.dart';
import 'package:coin/screen/top_5_coin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tabIndex = 0;

  List<Widget> tab = [
    Top100Coin(),
    Top5Coin(),
    SearchCoin(),
    FavoriteCoin(),
  ];

  void goTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab[
          tabIndex], // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.title), label: 'Top 100'),
          BottomNavigationBarItem(icon: Icon(Icons.title), label: 'Top 5'),
          BottomNavigationBarItem(icon: Icon(Icons.title), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.title), label: 'Favorite'),
        ],
        onTap: (index) => goTab(index),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex,
      ),
    );
  }
}
