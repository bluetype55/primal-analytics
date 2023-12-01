import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/search/s_stock_detail(dispose).dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data(dispose).dart';

class SearchHistoryStockList extends StatefulWidget {
  const SearchHistoryStockList({super.key});

  @override
  State<SearchHistoryStockList> createState() => _SearchHistoryStockListState();
}

class _SearchHistoryStockListState extends State<SearchHistoryStockList>
    with SearchStockDataProvider {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            '최근 조회 종목'.text.bold.make(),
            const EmptyExpanded(),
            Tap(
              onTap: () {
                searchData.removeAllHistory();
              },
              child: '전체 삭제'
                  .text
                  .size(12)
                  .color(context.appColors.lessImportant)
                  .make(),
            ),
          ],
        ).pSymmetric(h: 20),
        const Divider().pSymmetric(h: 20),
        SizedBox(
          width: double.infinity,
          height: 65,
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              scrollDirection: Axis.horizontal,
              itemCount: searchData.searchHistoryList.length,
              itemBuilder: (context, index) {
                final reversedIndex =
                    searchData.searchHistoryList.length - 1 - index;
                final stockName = searchData.searchHistoryList[reversedIndex];
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
        ).pOnly(left: 10),
      ],
    );
  }
}
