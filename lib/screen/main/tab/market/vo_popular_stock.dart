import 'package:fast_app_base/screen/main/tab/market/stock_percentage_data_provider.dart';
import 'package:fast_app_base/screen/main/tab/market/vo_simple_stock.dart';

class PopularStock extends SimpleStock with StockPercentageDataProvider {
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
