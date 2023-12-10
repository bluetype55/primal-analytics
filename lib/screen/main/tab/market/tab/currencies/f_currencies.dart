import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/stock_api/stock_service.dart';
import '../../../../../../data/stock_api/vo_stock_daily.dart';

class CurrenciesFragment extends StatelessWidget with StockServiceProvider {
  CurrenciesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: FutureBuilder<List<StockDaily>>(
            future: stockService.codeToData<StockDaily>('005930'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error.toString()}');
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                var stockDaily = snapshot.data!;

                // 데이터 포인트 생성
                List<FlSpot> spots = List.generate(stockDaily.length, (index) {
                  var stock = stockDaily[index];
                  return FlSpot(index.toDouble(), stock.close.toDouble());
                });

                return LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(show: true, leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots, // 생성한 데이터 포인트 사용
                        isCurved: false,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: true),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),
      ],
    );
  }
}
