import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';

class SimpleStockItem extends StatelessWidget {
  final StockData stock;
  const SimpleStockItem(this.stock, {super.key});

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
              stock.changesRatioString.text.bold
                  .color(stock.getPriceColor(context))
                  .make(),
              '${int.parse(stock.close).toComma()}원'
                  .text
                  .bold
                  .color(context.appColors.lessImportant)
                  .make(),
            ],
          ),
        ],
      ),
    );
  }
}
