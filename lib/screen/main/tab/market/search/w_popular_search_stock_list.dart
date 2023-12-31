import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/dart/extension/datetime_extension.dart';
import 'package:primal_analytics/screen/main/tab/market/search/s_stock_detail(dispose).dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_popular_search_stock_item.dart';

import 'dummy_popular_stock(dispose).dart';

class PopularSearchStockList extends StatelessWidget {
  const PopularSearchStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            '인기 검색 종목'.text.bold.make(),
            emptyExpanded,
            '오늘 ${DateTime.now().formattedTime} 기준'.text.size(12).make(),
          ],
        ),
        Divider(),
        ...popularStockListDummy
            .mapIndexed((element, index) => OpenContainer<bool>(
                  openColor:
                      context.themeType.themeData.scaffoldBackgroundColor,
                  closedColor:
                      context.themeType.themeData.scaffoldBackgroundColor,
                  openBuilder: (BuildContext context, VoidCallback action) {
                    return StockDetailScreen(
                      stockName: element.name,
                    );
                  },
                  closedBuilder: (BuildContext context, VoidCallback action) {
                    return PopularStockItem(
                      stock: element,
                      number: index + 1,
                    );
                  },
                ))
            .take(5)
            .toList(),
      ],
    ).pSymmetric(h: 20);
  }
}
