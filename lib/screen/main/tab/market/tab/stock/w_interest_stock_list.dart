import 'package:flutter/material.dart';
import 'package:primal_analytics/screen/main/tab/market/dummy_stock(dispose).dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_stock_item(dispose).dart';

class InterestStockList extends StatelessWidget {
  const InterestStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...myInterestStocks.map((element) => OriginStockItem(element)).toList(),
      ],
    );
  }
}
