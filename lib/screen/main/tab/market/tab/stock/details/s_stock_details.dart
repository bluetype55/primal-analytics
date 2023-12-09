import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock/details/w_line_chart.dart';

import '../../../../../../../data/stock_api/stock_service.dart';
import '../../../search/search_stock_data.dart';

class StockDetailsScreen extends StatelessWidget
    with StockServiceProvider, SearchStockDataProvider {
  final String code;
  StockDetailsScreen(
    this.code, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stock = stockService.findingDataWithCode<StockData>(code);
    final idstInfo = stockService.findingDataWithCode<StockIndustryInfo>(code);
    return WillPopScope(
      onWillPop: () async {
        searchData.addHistory(stock);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: stock!.name.text.make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: idstInfo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyLineChart(),
                    idstInfo.name.text.make(),
                    idstInfo.industry.text.make(),
                    idstInfo.mainProduct.text.make(),
                    idstInfo.webSite.text.make(),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
