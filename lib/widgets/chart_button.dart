import 'package:flutter/material.dart';

import '../screen/detail_coin.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(text),
        ),
      ),
    );
  }
}
