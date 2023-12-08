import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/widget/w_arrow.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/s_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/stock_filter_provider.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_stock_filter.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_stock_item_list.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_korean_market_dropdown.dart';

import '../../../../../../data/stock_api/stock_service.dart';

class StockSortingBox extends StatelessWidget
    with StockServiceProvider, StockFilterProvider {
  StockSortingBox(
    this.title, {
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.roundedLayoutBackgorund,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                width10,
                title.text.size(20).bold.make(),
                emptyExpanded,
                KoreanMarketDropdownButton(),
              ],
            ),
            StockFilter(),
            Column(
              children: [
                Obx(() => stockService.krxStockDataList.value != null
                        ? Column(
                            children: [
                              StockItemList(
                                stockService.krxStockDataList.value!,
                                limit: 5,
                                sortby: stockFilter.sortBy.value,
                                ascending: stockFilter.ascending.value,
                              ),
                              height10,
                            ],
                          ) // 데이터가 있으면 표시
                        : const Text('no data') // 데이터가 없으면 "no data" 표시
                    ),
              ],
            ),
            OpenContainer(
              transitionType: ContainerTransitionType.fade, // 애니메이션 효과 설정
              closedColor:
                  context.appColors.roundedLayoutBackgorund, // 닫힌 상태의 배경색
              closedBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      const EmptyExpanded(),
                      'more'.tr().text.make(),
                      const Arrow(
                        direction: AxisDirection.right,
                      ),
                    ],
                  ),
                ); // 아이템을 탭하면 상세 화면 열기
              },
              openBuilder: (context, action) {
                return stockService.krxStockDataList.value != null
                    ? StockListScreen(
                        title: title,
                        stockItemList: StockItemList(
                          stockService.krxStockDataList.value!,
                          sortby: stockFilter.sortBy.value,
                          ascending: stockFilter.ascending.value,
                        ),
                      )
                    : const Placeholder(); // 상세 화면 위젯 반환
              },
            ),
          ],
        ),
      ),
    );
  }
}
