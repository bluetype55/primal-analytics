import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';

import '../../../../../data/stock_api/stock_service.dart';

class StockDetailsScreen extends StatelessWidget {
  final String code;
  StockDetailsScreen(
    this.code, {
    super.key,
  });

  final StockService stockService = Get.find<StockService>();

  StockData? codeToStock(String code) {
    final stockList = stockService.krxStockDataList.value;
    if (stockList != null) {
      final stock = stockList.where((stock) => stock.code == code);
      return stock.first;
    } else {
      print('StockDetailsScreen : krxStockDataList 데이터 없음');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final stock = codeToStock(code);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: stock!.name.text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
