import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/dialog/d_confirm.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data_provider.dart';

import '../tab/stock/details/s_stock_details.dart';

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
                ConfirmDialog(
                  message: '조회 목록을 삭제 하시겠습니까?',
                  function: searchData.removeAllHistory,
                  confirmButtonText: 'clear'.tr(),
                  confirmButtonColor: context.appColors.allertText,
                ).show();
              },
              child: 'clear'
                  .tr()
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
                final stock = searchData.searchHistoryList[reversedIndex];
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          Tap(
                            onTap: () {
                              Nav.push(StockDetailsScreen(stock.code));
                            },
                            child: stock.name.text.make(),
                          ),
                          width5,
                          Tap(
                              onTap: () {
                                searchData.removeHistory(stock);
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
