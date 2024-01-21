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
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${stockPrediction[0].name} 예측 주가'),
                ],
              ),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('D + 1'),
                      Text('${stockPrediction[0].day1.toComma()}원'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('D + 2'),
                      Text('${stockPrediction[0].day2.toComma()}원'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('D + 3'),
                      Text('${stockPrediction[0].day3.toComma()}원'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('D + 4'),
                      Text('${stockPrediction[0].day4.toComma()}원'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('D + 5'),
                      Text('${stockPrediction[0].day5.toComma()}원'),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    ).pSymmetric(v: 20);
  }
}
