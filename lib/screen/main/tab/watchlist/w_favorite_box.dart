import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/favorite_provider.dart';

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
            height10,
            Row(
              children: [
                width10,
                const Icon(Icons.favorite, color: Colors.red),
                width10,
                'favorites'.tr().text.size(20).bold.make(),
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
                            limit: favoriteController.maxFavorites.value,
                          ),
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
