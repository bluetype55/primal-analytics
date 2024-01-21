import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_stock_data_provider.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_simple_stock_item.dart';

import '../tab/stock/details/s_stock_details.dart';

class SearchAutoCompleteList extends StatelessWidget
    with SearchStockDataProvider {
  final TextEditingController controller;
  SearchAutoCompleteList(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final stock = searchData.autoCompleteStocksList[index];
        return OpenContainer(
          transitionType: ContainerTransitionType.fade, // 애니메이션 효과 설정
          closedColor: Colors.transparent, // 닫힌 상태의 배경색
          closedBuilder: (context, action) {
            return SimpleStockItem(stock); // 아이템을 탭하면 상세 화면 열기
          },
          openBuilder: (context, action) {
            return StockDetailsScreen(stock.code); // 상세 화면 위젯 반환
          },
        );
      },
      itemCount: searchData.autoCompleteStocksList.length,
    );
  }
}
