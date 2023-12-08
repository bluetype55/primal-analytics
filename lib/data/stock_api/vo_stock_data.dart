import 'package:primal_analytics/data/stock_api/vo_simple_stock.dart';

import '../../screen/main/tab/market/stock_data_color_provider.dart';

class StockData extends SimpleStock with StockDataColorProvider {
  // final String name;
  // final String market;
  // final String code;
  final String close;
  @override
  final int changes;
  @override
  final double changesRatio;
  final int open;
  final int high;
  final int low;
  final int volume;
  final int amount;
  final int marcap;
  final int stocks;
  final String marketId;

  StockData(
    String name,
    String market,
    String code,
    this.close,
    this.changes,
    this.changesRatio,
    this.open,
    this.high,
    this.low,
    this.volume,
    this.amount,
    this.marcap,
    this.stocks,
    this.marketId,
  ) : super(name, market, code);

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      json['Name'],
      json['Market'],
      json['Code'],
      json['Close'],
      json['Changes'],
      json['ChagesRatio'],
      json['Open'],
      json['High'],
      json['Low'],
      json['Volume'],
      json['Amount'],
      json['Marcap'],
      json['Stocks'],
      json['MarketId'],
    );
  }
}
