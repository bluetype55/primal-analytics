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
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyLineChart(code),
            FutureBuilder<List<StockIndustryInfo>>(
              future: stockService.codeToData<StockIndustryInfo>(code),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error.toString()}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  var stockIdst = snapshot.data![0];
                  return Column(
                    children: [
                      stockIdst.name.text.make(),
                      stockIdst.industry.text.make(),
                      stockIdst.mainProduct.text.make(),
                      stockIdst.webSite.text.make(),
                    ],
                  );

                } else {
                  return const Text('No data available');
                }
              },),
                  ],
                ),
        ),
      ),
    );
  }
}
