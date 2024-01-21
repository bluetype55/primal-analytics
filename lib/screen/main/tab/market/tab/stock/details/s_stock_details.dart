import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/favorite_provider.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_favorite_heart.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_industry_info_box.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_simple_stock_info.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_stock_candle_chart.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_stock_learning_chart.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_stock_prediction_box.dart';

import '../../../../../../../data/stock_api/finance_service.dart';
import '../../../search/search_stock_data_provider.dart';

class StockDetailsScreen extends StatelessWidget
    with FinanceServiceProvider, SearchStockDataProvider, FavoriteProvider {
  final String code;
  StockDetailsScreen(
    this.code, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stock = finService.findingDataWithCode<StockData>(code);

    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        searchData.addHistory(stock);
        searchData.saveStockView(stock);
        favoriteController.addMyWatchlist(code);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: stock!.name.text.make(),
          actions: [FavoriteHeartWidget(code)],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleStockInfo(code),
              StockCandleChart(code).pSymmetric(v: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  '학습데이터'.text.make(),
                ],
              ),
              StockLearningChart(code).pSymmetric(v: 20),
              StockPredictionBox(code),
              IdstBox(code).pSymmetric(v: 20),
            ],
          ).pSymmetric(v: 20),
        ),
      ),
    );
  }
}
