import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/finance_service.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_mini_stock_chart.dart';

import '../../../../../../../data/stock_api/vo_stock_data.dart';

class SimpleStockInfo extends StatelessWidget with FinanceServiceProvider {
  SimpleStockInfo(this.code, {super.key});
  final String code;

  @override
  Widget build(BuildContext context) {
    final stock = finService.findingDataWithCode<StockData>(code);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MiniStockChart(code),
          if (stock != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    '${stock.code} / ${stock.market}'
                        .text
                        .color(context.appColors.lessImportant)
                        .make(),
                  ],
                ),
                Row(
                  children: [
                    '${int.parse(stock.close).toComma()}원'
                        .text
                        .bold
                        .size(30)
                        .color(stock.getPriceColor(context))
                        .make(),
                  ],
                ),
                Row(
                  children: [
                    stock.icon(context),
                    stock.changesString.text.bold
                        .color(stock.getPriceColor(context))
                        .make(),
                  ],
                ),
                Row(
                  children: [
                    '거래량 ${stock.volume.toComma()}주'.text.make(),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
