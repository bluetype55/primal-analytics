import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_daily.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';

import '../../../../../../../data/stock_api/finance_service.dart';

class MiniStockChart extends StatelessWidget with FinanceServiceProvider {
  MiniStockChart(this.code, {super.key});

  final String code;
  @override
  Widget build(BuildContext context) {
    var stock = finService.findingDataWithCode<StockData>(code);
    Color spotColor = context.appColors.text;
    if (stock != null) {
      spotColor = stock.getPriceColor(context);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: SizedBox(
        height: 120,
        width: 200,
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
              List<FlSpot> actualSpots =
                  List.generate(stockDaily.length, (index) {
                var stock = stockDaily[index];
                return FlSpot(index.toDouble(), stock.close.toDouble());
              });

              return LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((touchedSpot) {
                          // 해당 스팟에 대한 데이터 찾기
                          final spotIndex = touchedSpot.spotIndex;
                          final spotData = stockDaily[spotIndex];

                          // 툴팁에 표시할 텍스트 생성
                          final tooltipText =
                              '￦${spotData.date}\n${spotData.close.toComma()}';

                          return LineTooltipItem(
                            tooltipText,
                            TextStyle(color: context.appColors.text),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: actualSpots, // 실제 차트
                      isCurved: false,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: true),
                      color: spotColor,
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
    );
  }
}
