import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_stock_item_list.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_korean_market_dropdown.dart';

class StockListScreen extends StatelessWidget {
  final String title;
  final StockItemList stockItemList;
  const StockListScreen({
    required this.title,
    super.key,
    required this.stockItemList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appColors.roundedLayoutBackgorund,
        title: title.text.bold.make(),
        actions: [
          KoreanMarketDropdownButton(),
          width20,
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: context.appColors.roundedLayoutBackgorund,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              stockItemList,
            ],
          ),
        ),
      ),
    );
  }
}
