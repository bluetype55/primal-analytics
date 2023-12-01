import 'package:primal_analytics/screen/main/tab/market/stock_percentage_data_provider(dispose).dart';
import 'package:primal_analytics/screen/main/tab/market/vo_simple_stock(dispose).dart';

class PopularStock extends SimpleStockDispose with StockPercentageDataProvider {
  @override
  final int yesterdayClosePrice;
  @override
  final int currentPrice;

  PopularStock({
    required String stockName,
    required this.yesterdayClosePrice,
    required this.currentPrice,
  }) : super(stockName);
}
