import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/vo_popular_stock(dispose).dart';

class PopularStockItem extends StatelessWidget {
  final PopularStock stock;
  final int number;
  const PopularStockItem(
      {super.key, required this.stock, required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        number.text.make(),
        width30,
        stock.name.text.make(),
        emptyExpanded,
        stock.todayPercentageString.text
            .color(stock.getPriceColor(context))
            .make(),
      ],
    ).pSymmetric(v: 25);
  }
}
