import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyLineChart extends StatelessWidget {
  const MyLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        maxY: 10,
        maxX: 10,
        minX: 0,
        minY: 0,
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 1),
              const FlSpot(1, 3),
              const FlSpot(2, 10),
              const FlSpot(3, 7),
              // 여기에 데이터 포인트 추가
            ],
            isCurved: true, // 곡선 스타일로 라인 차트
            barWidth: 5, // 라인 두께
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true), // 데이터 포인트에 점 표시
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
