import 'package:coin/screen/detail_coin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/model/coin_entity.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({Key? key, required this.coin}) : super(key: key);

  final CoinEntity coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () => Get.to(() => const DetailCoin(), arguments: coin.toJson()),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  (coin.top ?? 0).toString(),
                ),
                const SizedBox(width: 10),
                Image.network(
                  coin.image ?? '',
                  width: 50,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    coin.name ?? 'None',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(coin.price ?? '0'),
                    Text((coin.percent ?? 0).toString() + '%'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
