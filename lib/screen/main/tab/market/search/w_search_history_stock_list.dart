import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/dialog/d_confirm.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data.dart';

import '../tab/s_stock_details.dart';

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
                  function: searchData.removeAllHistory,
                ).show();
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
                final stock = searchData.searchHistoryList[reversedIndex];
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          OpenContainer(
                            transitionType:
                                ContainerTransitionType.fade, // 애니메이션 효과 설정
                            closedColor: Colors.transparent, // 닫힌 상태의 배경색
                            closedBuilder: (context, action) {
                              return stock.name.text
                                  .make(); // 아이템을 탭하면 상세 화면 열기
                            },
                            openBuilder: (context, action) {
                              return StockDetailsScreen(
                                  stock.code); // 상세 화면 위젯 반환
                            },
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
