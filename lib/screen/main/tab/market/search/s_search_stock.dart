import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data_provider.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_popular_search_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_search_auto_coplete_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_search_history_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_stock_search_app_bar.dart';

class SearchStockScreen extends StatelessWidget with SearchStockDataProvider {
  SearchStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockSearchAppBar(
        controller: searchData.keywordController,
      ),
      body: Obx(
        () => searchData.autoCompleteStocksList.isEmpty
            ? ListView(
                children: [
                  searchData.searchHistoryList.isEmpty
                      ? Container()
                      : const SearchHistoryStockList(),
                  //const PopularSearchWordList(),
                  PopularSearchStockList(),
                ],
              )
            : SearchAutoCompleteList(searchData.keywordController)
                .pSymmetric(h: 10),
      ),
    );
  }
}
