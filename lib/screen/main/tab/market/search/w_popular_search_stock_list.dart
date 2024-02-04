import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/dart/extension/datetime_extension.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_provider.dart';
import 'package:primal_analytics/screen/main/tab/market/search/w_popular_search_stock_item.dart';

import '../../../../../data/stock_api/vo_stock_data.dart';
import '../tab/stock/details/s_stock_details.dart';

class PopularSearchStockList extends StatelessWidget with SearchProvider {
  PopularSearchStockList(this.stockList, {super.key});
  final List<StockData> stockList;

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
        const Divider(),
        ...stockList
            .mapIndexed((element, index) => OpenContainer<bool>(
                  openColor:
                      context.themeType.themeData.scaffoldBackgroundColor,
                  closedColor:
                      context.themeType.themeData.scaffoldBackgroundColor,
                  openBuilder: (BuildContext context, VoidCallback action) {
                    return StockDetailsScreen(element.code);
                  },
                  closedBuilder: (BuildContext context, VoidCallback action) {
                    return PopularStockItem(
                      stock: element,
                      number: index + 1,
                    );
                  },
                ))
            .take(10)
            .toList(),
      ],
    ).pSymmetric(h: 20);
  }
}
