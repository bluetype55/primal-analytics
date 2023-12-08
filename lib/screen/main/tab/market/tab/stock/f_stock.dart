import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_stock_sorting_box.dart';

class StockFragment extends StatelessWidget {
  const StockFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockSortingBox('국내'),
        height20,
        botNavBarHeight,
      ],
    );
  }
}
