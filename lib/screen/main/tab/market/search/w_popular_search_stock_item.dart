import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';

class PopularStockItem extends StatelessWidget {
  final StockData stock;
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
        stock.changesRatioString.text
            .color(stock.getPriceColor(context))
            .make(),
      ],
    ).pSymmetric(v: 25);
  }
}
