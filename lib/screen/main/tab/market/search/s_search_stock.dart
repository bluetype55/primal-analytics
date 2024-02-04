import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_provider.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_popular_search_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_search_auto_coplete_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_search_history_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_stock_search_app_bar.dart';

class SearchStockScreen extends StatelessWidget with SearchProvider {
  SearchStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockSearchAppBar(
        controller: searchDataController.keywordController,
      ),
      body: FutureBuilder(
        future: searchDataController.getTodayStockRaking(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Obx(() => searchDataController.autoCompleteStocksList.isEmpty
              ? ListView(
                  children: [
                    searchDataController.searchHistoryList.isEmpty
                        ? Container()
                        : const SearchHistoryStockList(),
                    PopularSearchStockList(
                        searchDataController.popularStockList),
                  ],
                )
              : SearchAutoCompleteList(searchDataController.keywordController)
                  .pSymmetric(h: 10));
        },
      ),
    );
  }
}
