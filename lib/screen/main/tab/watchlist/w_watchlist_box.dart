import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/data/stock_api/finance_service.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/w_stock_item_list.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/favorite_provider.dart';

import '../../../../common/common.dart';

class WatchlistBox extends StatelessWidget
    with FavoriteProvider, FinanceServiceProvider {
  WatchlistBox({super.key});

  @override
  Widget build(BuildContext context) {
    //print(favoriteController.watchStocklist.value);
    return Container(
      color: context.appColors.roundedLayoutBackgorund,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
        child: Column(
          children: [
            height10,
            Row(
              children: [
                width10,
                const Icon(Icons.star, color: Colors.yellow),
                width10,
                '내가 자주 찾아 본 종목'.text.size(20).bold.make(),
                emptyExpanded,
              ],
            ),
            Column(
              children: [
                Obx(() => favoriteController.watchStocklist.value != null &&
                        favoriteController.watchStocklist.value!.isNotEmpty
                    ? Column(
                        children: [
                          StockItemList(
                              favoriteController.watchStocklist.value!,
                              limit: 5),
                          height10,
                        ],
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(child: Text('목록이 비어 있습니다.')))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
