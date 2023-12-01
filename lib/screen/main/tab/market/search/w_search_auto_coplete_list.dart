import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data(dispose).dart';

import '../tab/s_stock_details.dart';

class SearchAutoCompleteList extends StatelessWidget
    with SearchStockDataProvider {
  final TextEditingController controller;
  SearchAutoCompleteList(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final stockIdstInfo = searchData.autoCompleteStocksList[index];
        return Tap(
          onTap: () {
            Nav.push(StockDetailsScreen(stockIdstInfo.code));
            controller.clear();
            searchData.addHistory(stockIdstInfo.name);
          },
          child: stockIdstInfo.name.text.make(),
        );
      },
      itemCount: searchData.autoCompleteStocksList.length,
    );
  }
}
