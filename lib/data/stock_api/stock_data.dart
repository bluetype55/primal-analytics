import '../../screen/main/tab/market/stock_data_color_provider.dart';

class StockData with StockDataColorProvider {
  final String name;
  final String market;
  final String code;
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

  StockData(
      this.name,
      this.market,
      this.code,
      this.close,
      this.changes,
      this.changesRatio,
      this.open,
      this.high,
      this.low,
      this.volume,
      this.amount,
      this.marcap,
      this.stocks);

  factory StockData.fromJson(dynamic json) {
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
    );
  }

  static List<StockData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((data) => StockData.fromJson(data)).toList();
  }

  @override
  String toString() {
    return name;
  }
}
