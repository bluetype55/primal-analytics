import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';

import '../../../../../../../data/stock_api/finance_service.dart';
import '../../../../../../../data/stock_api/vo_stock_daily.dart';

class StockLineChart extends StatelessWidget with FinanceServiceProvider {
  StockLineChart(this.code, {super.key});

  final String code;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: FutureBuilder<List<StockDaily>>(
        future: finService.codeToData<StockDaily>(code),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error.toString()}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var stockDaily = snapshot.data!;

            // 데이터 포인트 생성

            List<Candle> candles = List.generate(stockDaily.length, (index) {
              var stock = stockDaily[index];
              return Candle(
                date: DateTime.parse(stock.date),
                high: stock.high.toDouble(),
                low: stock.low.toDouble(),
                open: stock.open.toDouble(),
                close: stock.close.toDouble(),
                volume: stock.volume.toDouble(),
              );
            });

            return Candlesticks(candles: candles);
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }
}
