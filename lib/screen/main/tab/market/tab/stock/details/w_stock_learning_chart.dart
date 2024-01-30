import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_test.dart';

import '../../../../../../../data/stock_api/finance_service.dart';

class StockLearningChart extends StatelessWidget with FinanceServiceProvider {
  StockLearningChart(this.code, {super.key});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        '학습 데이터'.text.size(18).bold.make(),
        height10,
        const Row(
          children: [
            width10,
            Icon(
              Icons.trending_flat,
              color: Colors.red,
            ),
            Text('예측 데이터'),
            width10,
            Icon(
              Icons.trending_flat,
              color: Colors.blue,
            ),
            Text('실제 데이터'),
          ],
        ),
        FutureBuilder<List<StockTest>>(
          future: finService.codeToData<StockTest>(code),
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
                return FlSpot(index.toDouble(), stock.actual.toDouble());
              });

              List<FlSpot> predSpots =
                  List.generate(stockDaily.length, (index) {
                var stock = stockDaily[index];
                return FlSpot(index.toDouble(), stock.predicted);
              });

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: SizedBox(
                  height: 300,
                  width: 1000,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30, // X축 레이블의 공간 예약
                            getTitlesWidget: (double value, TitleMeta meta) {
                              String title; // X축 인덱스에 해당하는 날짜 가져오기
                              if (value == meta.max) {
                                // 마지막 타이틀인 경우
                                title = '';
                              } else if (value % (meta.appliedInterval * 2) ==
                                  0) {
                                title = '';
                              } else {
                                // 나머지 타이틀
                                title = DateFormat('yy-MM-dd').format(
                                        DateTime.parse(
                                            stockDaily[value.toInt()].date)) ??
                                    ''; // 일반 타이틀 텍스트
                              }
                              return Text(
                                title,
                                style: TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 70,
                            getTitlesWidget: (value, meta) {
                              String title;
                              if (value == meta.max) {
                                // 마지막 타이틀인 경우
                                title = '';
                              } else if (value == meta.min) {
                                // 마지막 타이틀인 경우
                                title = '';
                              } else {
                                title =
                                    '￦${((value / 10).round() * 10).toComma()}';
                              }
                              return Text(
                                title,
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 10,
                            getTitlesWidget: (value, meta) {
                              return Text('');
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 10,
                            getTitlesWidget: (value, meta) {
                              return Text('');
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,
                          maxContentWidth: 200,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((touchedSpot) {
                              final spotIndex = touchedSpot.spotIndex;
                              final spotData = stockDaily[spotIndex];
                              // 예측 데이터 스팟인 경우 툴팁을 표시하지 않음
                              if (touchedSpot.barIndex == 1) {
                                return null;
                              }
                              // 실제 데이터 스팟인 경우 툴팁 표시
                              final tooltipText =
                                  '${spotData.date}\n실제가: ￦${spotData.actual.toComma()}\n예측가: ￦${spotData.predicted.round().toComma()}';

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
                        ),
                        LineChartBarData(
                          spots: predSpots, // 예측 차트
                          isCurved: false,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: true),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      size: 50,
                    ),
                    height20,
                    '학습 데이터가 없습니다.'.text.size(15).make(),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
