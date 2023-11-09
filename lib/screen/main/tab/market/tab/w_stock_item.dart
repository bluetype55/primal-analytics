import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/stock_data.dart';

class StockItem extends StatelessWidget {
  final StockData stock;
  const StockItem(this.stock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              width10,
              (stock.name).text.size(18).bold.make(),
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
