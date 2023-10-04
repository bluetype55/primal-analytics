import 'package:animations/animations.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/s_stock_detail.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_popular_search_stock_item.dart';
import 'package:flutter/material.dart';

import 'dummy_popular_stock.dart';

class PopularSearchStockList extends StatelessWidget {
  const PopularSearchStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            '인기 검색'.text.bold.make(),
            emptyExpanded,
            '오늘 ${DateTime.now().formattedTime} 기준'.text.size(12).make(),
          ],
        ),
        height20,
        ...popularStockList
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
            .toList(),
      ],
    ).pSymmetric(h: 20);
  }
}
