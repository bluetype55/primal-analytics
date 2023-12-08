import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

import '../../vo_stock(dispose).dart';

class OriginStockItem extends StatelessWidget {
  final Stock stock;
  const OriginStockItem(this.stock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          width10,
          (stock.name).text.size(18).bold.make(),
          emptyExpanded,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              stock.todayPercentageString.text
                  .color(stock.getPriceColor(context))
                  .make(),
              '${stock.currentPrice.toComma()}원'
                  .text
                  .color(context.appColors.lessImportant)
                  .make(),
            ],
          ),
        ],
      ),
    );
  }
}
