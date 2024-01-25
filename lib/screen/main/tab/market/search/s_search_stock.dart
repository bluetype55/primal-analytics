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
      body: FutureBuilder(
        future: searchData.getTodayStockRaking(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Obx(() => searchData.autoCompleteStocksList.isEmpty
              ? ListView(
                  children: [
                    searchData.searchHistoryList.isEmpty
                        ? Container()
                        : const SearchHistoryStockList(),
                    PopularSearchStockList(searchData.popularStockList),
                  ],
                )
              : SearchAutoCompleteList(searchData.keywordController)
                  .pSymmetric(h: 10));
        },
      ),
    );
  }
}
