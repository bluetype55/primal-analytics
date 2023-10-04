import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/s_stock_detail.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/search_stock_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHistoryStockList extends StatefulWidget {
  const SearchHistoryStockList({super.key});

  @override
  State<SearchHistoryStockList> createState() => _SearchHistoryStockListState();
}

class _SearchHistoryStockListState extends State<SearchHistoryStockList>
    with SearchStockDataProvider {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          scrollDirection: Axis.horizontal,
          itemCount: searchData.searchHistoryList.length,
          itemBuilder: (context, index) {
            final stockName = searchData.searchHistoryList[index];
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Tap(
                          onTap: () {
                            Nav.push(StockDetailScreen(
                              stockName: stockName,
                            ));
                          },
                          child: stockName.text.make()),
                      width5,
                      Tap(
                          onTap: () {
                            searchData.removeHistory(stockName);
                          },
                          child: const Icon(Icons.close, size: 12)),
                    ],
                  )
                      .box
                      .withRounded(value: 6)
                      .color(context.appColors.roundedLayoutBackgorund)
                      .p8
                      .make(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
