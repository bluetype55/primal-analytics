import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

class StockDetailScreen extends StatelessWidget {
  final String stockName;
  const StockDetailScreen({
    required this.stockName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.themeType.themeData.colorScheme.background,
        title: Text(stockName),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '주식 상세'.text.make(),
          ],
        ),
      ),
    );
  }
}
