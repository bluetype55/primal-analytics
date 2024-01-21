import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/favorite_provider.dart';

import '../market/tab/stock/w_stock_item_list.dart';

class FavoriteBox extends StatelessWidget with FavoriteProvider {
  FavoriteBox({super.key});

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
                const Icon(Icons.favorite, color: Colors.red),
                width10,
                '내가 찜한 종목'.text.size(20).bold.make(),
                emptyExpanded,
              ],
            ),
            Column(
              children: [
                Obx(() => favoriteController.favoriteStockList.value != null &&
                        favoriteController.favoriteStockList.value!.isNotEmpty
                    ? Column(
                        children: [
                          StockItemList(
                              favoriteController.favoriteStockList.value!,
                              limit: 5),
                          height30,
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
