import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coin/model/coin_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/model/price.dart';

class DetailCoin extends StatefulWidget {
  const DetailCoin({Key? key}) : super(key: key);

  @override
  State<DetailCoin> createState() => _DetailCoinState();
}

class _DetailCoinState extends State<DetailCoin> {
  CoinEntity coin = CoinEntity();
  List<charts.Series<Price, DateTime>> _seriesDataDay = [];
  List<charts.Series<Price, DateTime>> _seriesDataWeek = [];
  List<charts.Series<Price, DateTime>> _seriesDataMonth = [];
  List<charts.Series<Price, DateTime>> _seriesDataYear = [];
  List<charts.Series<Price, DateTime>> data = [];
  ChartStatus status = ChartStatus.day;

  @override
  void initState() {
    super.initState();
    coin = CoinEntity.fromJson(Get.arguments);
    getData();
  }

  void getData() async {
    _seriesDataDay = await getApi(24);
    _seriesDataWeek = await getApi(24 * 7);
    _seriesDataMonth = await getApi(24 * 7 * 4);
    _seriesDataYear = await getApi(24 * 7 * 4 * 12);
    setState(() {
      data = _seriesDataDay;
    });
  }

  Future<List<charts.Series<Price, DateTime>>> getApi(int hour) async {
    List<Price> chart = [];
    List<charts.Series<Price, DateTime>> _seriesData = [];
    String from = (DateTime.now()
                .subtract(Duration(hours: hour))
                .toUtc()
                .millisecondsSinceEpoch /
            1000)
        .round()
        .toString();
    String to = (DateTime.now().toUtc().millisecondsSinceEpoch / 1000)
        .round()
        .toString();
    final response = await Dio().get(
        'https://api.coingecko.com/api/v3/coins/${coin.id}/market_chart/range?vs_currency=usd&from=$from&to=$to');

    for (var price in response.data["prices"]) {
      Price temp = Price(
          time: DateTime.fromMillisecondsSinceEpoch(price[0]), price: price[1]);
      if (temp.price != null && temp.time != null) {
        chart.add(temp);
      }
    }

    chart.sort((a, b) => a.time!.compareTo(b.time!));

    _seriesData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(
          const Color(0xff109618),
        ),
        id: 'Price',
        data: chart,
        domainFn: (Price price, _) => price.time!,
        measureFn: (Price price, _) => price.price!,
      ),
    );
    return _seriesData;
  }

  void clickStatus(ChartStatus _status) {
    setState(() {
      status = _status;
    });

    switch (_status) {
      case ChartStatus.day:
        setState(() {
          data = _seriesDataDay;
        });
        break;
      case ChartStatus.month:
        setState(() {
          data = _seriesDataMonth;
        });
        break;
      case ChartStatus.week:
        setState(() {
          data = _seriesDataWeek;
        });
        break;
      case ChartStatus.year:
        setState(() {
          data = _seriesDataYear;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(child: buildChart()),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChartButton(
                  status: status,
                  press: () => clickStatus(ChartStatus.day),
                  text: 'Day',
                  selected: status == ChartStatus.day,
                ),
                ChartButton(
                  status: status,
                  press: () => clickStatus(ChartStatus.week),
                  text: 'Week',
                  selected: status == ChartStatus.week,
                ),
                ChartButton(
                  status: status,
                  press: () => clickStatus(ChartStatus.month),
                  text: 'Month',
                  selected: status == ChartStatus.month,
                ),
                ChartButton(
                  status: status,
                  press: () => clickStatus(ChartStatus.year),
                  text: 'Year',
                  selected: status == ChartStatus.year,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text(
          coin.name ?? 'Coin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      );

  Widget buildChart() {
    if (data.isEmpty) {
      return const Text('Loading');
    }
    return SizedBox(
      child: charts.TimeSeriesChart(
        data,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }
}

enum ChartStatus { day, week, month, year }

class ChartButton extends StatelessWidget {
  const ChartButton(
      {Key? key,
      required this.status,
      required this.press,
      required this.text,
      required this.selected})
      : super(key: key);

  final ChartStatus status;
  final Function press;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => press(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: selected ? Colors.grey.withOpacity(.3) : Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(text),
        ),
      ),
    );
  }
}
