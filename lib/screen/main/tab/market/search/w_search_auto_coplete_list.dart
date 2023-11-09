import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/search/s_stock_detail.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data.dart';

class SearchAutoCompleteList extends StatelessWidget
    with SearchStockDataProvider {
  final TextEditingController controller;
  SearchAutoCompleteList(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final stock = searchData.autoCompleteList[index];
        String stockName = stock.name;
        return Tap(
            onTap: () {
              Nav.push(StockDetailScreen(
                stockName: stockName,
              ));
              controller.clear();
              searchData.addHistory(stock);
            },
            child: stockName.text.make().p(20));
      },
      itemCount: searchData.autoCompleteList.length,
    );
  }
}
