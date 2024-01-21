import 'package:flutter/material.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:primal_analytics/common/common.dart';

import '../../../../../../../data/stock_api/finance_service.dart';
import '../../../../../../../data/stock_api/vo_stock_daily.dart';

class StockCandleChart extends StatelessWidget with FinanceServiceProvider {
  StockCandleChart(this.code, {super.key});

  final String code;

  List<KLineEntity>? datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = false;
  bool _hideGrid = false;
  bool _showNowPrice = true;
  List<DepthEntity>? _bids, _asks;
  bool isChangeUI = true;
  bool _isTrendLine = false;
  bool _priceLeft = true;
  List<int> _maDayList = [5, 10, 20];
  VerticalTextAlignment _verticalTextAlignment = VerticalTextAlignment.right;
  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  @override
  Widget build(BuildContext context) {
    chartColors.upColor = context.appColors.plus;
    chartColors.dnColor = context.appColors.minus;
    chartColors.bgColor = [Colors.transparent, Colors.transparent];

    return SizedBox(
      height: 400,
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
            datas = List.generate(stockDaily.length, (index) {
              var stock = stockDaily[index];
              return KLineEntity.fromCustom(
                time: DateTime.parse(stock.date).millisecondsSinceEpoch,
                high: stock.high.toDouble(),
                low: stock.low.toDouble(),
                open: stock.open.toDouble(),
                close: stock.close.toDouble(),
                vol: stock.volume.toDouble(),
              );
            });
            DataUtil.calculate(datas!);
            return KChartWidget(
              datas,
              chartStyle,
              chartColors,
              isLine: isLine,
              onSecondaryTap: () {
                print('Secondary Tap');
              },
              isTrendLine: _isTrendLine,
              mainState: _mainState,
              volHidden: _volHidden,
              secondaryState: _secondaryState,
              fixedLength: 2,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              showNowPrice: _showNowPrice,
              hideGrid: _hideGrid,
              isTapShowInfoDialog: false,
              verticalTextAlignment: _verticalTextAlignment,
              maDayList: _maDayList,
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }
}
