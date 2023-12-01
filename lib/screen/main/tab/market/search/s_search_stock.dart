import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data(dispose).dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_popular_search_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_popular_search_word_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_search_auto_coplete_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_search_history_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_stock_search_app_bar.dart';

class SearchStockScreen extends StatefulWidget {
  const SearchStockScreen({super.key});

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen>
    with SearchStockDataProvider {
  final controller = TextEditingController();

  @override
  void initState() {
    Get.put(SearchStockData());
    controller.addListener(() {
      searchData.search(controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockSearchAppBar(
        controller: controller,
      ),
      body: Obx(
        () => searchData.autoCompleteStocksList.isEmpty
            ? ListView(
                children: [
                  searchData.searchHistoryList.isEmpty
                      ? Container()
                      : const SearchHistoryStockList(),
                  const PopularSearchWordList(),
                  const PopularSearchStockList(),
                ],
              )
            : SearchAutoCompleteList(controller),
      ),
    );
  }
}
