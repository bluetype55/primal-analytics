import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/finance_service.dart';

import '../../../../../../../data/stock_api/vo_stock_prediction.dart';

class StockPredictionBox extends StatelessWidget with FinanceServiceProvider {
  StockPredictionBox(this.code, {super.key});
  final String code;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StockPrediction>>(
      future: finService.codeToData<StockPrediction>(code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text('Error: ${snapshot.error.toString()}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          var stockPrediction = snapshot.data!;
          // 데이터 포인트 생성
          var stock = stockPrediction[0];
          List<BarChartGroupData> barGroups = [
            BarChartGroupData(
                x: 0, barRods: [BarChartRodData(toY: stock.day1.toDouble())]),
            BarChartGroupData(
                x: 1, barRods: [BarChartRodData(toY: stock.day2.toDouble())]),
            BarChartGroupData(
                x: 2, barRods: [BarChartRodData(toY: stock.day3.toDouble())]),
            BarChartGroupData(
                x: 3, barRods: [BarChartRodData(toY: stock.day4.toDouble())]),
            BarChartGroupData(
                x: 4, barRods: [BarChartRodData(toY: stock.day5.toDouble())]),
          ];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  '${stockPrediction[0].name} 예측 주가'.text.size(18).bold.make(),
                ],
              ),
              height20,
              SizedBox(
                height: 200,
                width: 350,
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 45,
                          getTitlesWidget: (value, meta) {
                            String text =
                                '￦ ${(((value / 10).round()) * 10).toComma()}';
                            if (value == meta.min) {
                              // 마지막 타이틀인 경우
                              text = '';
                            }
                            return Text(
                              text,
                              style: TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (value, meta) {
                            String title =
                                'D + ${int.parse(meta.formattedValue) + 1}';
                            return Column(
                              children: [
                                height10,
                                Text(
                                  title,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: barGroups,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final tooltipText =
                              'D + ${groupIndex + 1}\n￦ ${(((rod.toY / 10).round()) * 10).toComma()}';
                          return BarTooltipItem(tooltipText,
                              TextStyle(color: context.appColors.text));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_outlined,
                    size: 30,
                  ),
                  height20,
                  '학습 데이터가 없습니다.'.text.size(10).make(),
                ],
              ),
            ],
          );
        }
      },
    ).pSymmetric(v: 20);
  }
}
