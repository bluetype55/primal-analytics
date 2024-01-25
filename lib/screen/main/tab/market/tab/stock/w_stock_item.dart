import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';

class StockItem extends StatelessWidget {
  final StockData stock;
  final int numb;
  const StockItem(this.stock, this.numb, {super.key});

  @override
  Widget build(BuildContext context) {
    String displayName =
        stock.name.length > 7 ? '${stock.name.substring(0, 7)}...' : stock.name;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (displayName)
                      .text
                      .maxLines(1)
                      .overflow(TextOverflow.ellipsis)
                      .size(18)
                      .bold
                      .make(),
                  '$numb. | ${stock.market}'
                      .text
                      .size(12)
                      .bold
                      .color(context.appColors.lessImportant)
                      .make(),
                ],
              ),
              emptyExpanded,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  '${int.parse(stock.close).toComma()}원'
                      .text
                      .size(16)
                      .bold
                      .color(context.appColors.lessImportant)
                      .make(),
                  Row(
                    children: [
                      stock.icon(context),
                      stock.changesString.text.bold
                          .color(stock.getPriceColor(context))
                          .make(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Line(
          color: context.appColors.divider,
        ),
      ],
    );
  }
}
