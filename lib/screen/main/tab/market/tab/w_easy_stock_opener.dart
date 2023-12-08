import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/s_stock_details.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_stock_item.dart';

import '../../../../../data/stock_api/vo_stock_data.dart';

class EasyStockOpener extends StatelessWidget {
  const EasyStockOpener({
    super.key,
    this.stocks,
    this.iterable,
    this.stockData,
    required this.index,
  });

  final List<StockData>? stocks;
  final Iterable<StockData>? iterable;
  final StockData? stockData;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (stocks != null) {
      return OpenContainer(
        transitionType: ContainerTransitionType.fade, // 애니메이션 효과 설정
        closedColor: context.appColors.roundedLayoutBackgorund, // 닫힌 상태의 배경색
        closedBuilder: (context, action) {
          return StockItem(stocks![index], index + 1); // 아이템을 탭하면 상세 화면 열기
        },
        openBuilder: (context, action) {
          return StockDetailsScreen(stocks![index].code); // 상세 화면 위젯 반환
        },
      );
    } else if (iterable != null) {
      return OpenContainer(
        transitionType: ContainerTransitionType.fade, // 애니메이션 효과 설정
        closedColor: context.appColors.roundedLayoutBackgorund, // 닫힌 상태의 배경색
        closedBuilder: (context, action) {
          return StockItem(
              iterable!.elementAt(index), index + 1); // 아이템을 탭하면 상세 화면 열기
        },
        openBuilder: (context, action) {
          return StockDetailsScreen(
              iterable!.elementAt(index).code); // 상세 화면 위젯 반환
        },
      );
    } else if (stockData != null) {
      return OpenContainer(
        transitionType: ContainerTransitionType.fade, // 애니메이션 효과 설정
        closedColor: context.appColors.roundedLayoutBackgorund, // 닫힌 상태의 배경색
        closedBuilder: (context, action) {
          return StockItem(stockData!, index + 1); // 아이템을 탭하면 상세 화면 열기
        },
        openBuilder: (context, action) {
          return StockDetailsScreen(stockData!.code); // 상세 화면 위젯 반환
        },
      );
    } else {
      return 'no data'.text.make();
    }
  }
}
