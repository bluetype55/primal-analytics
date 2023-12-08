class StockDaily {
  final String date;
  final int open;
  final int high;
  final int low;
  final int close;
  final int volume;
  final double change;

  StockDaily(
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.change,
  );

  factory StockDaily.fromJson(Map<String, dynamic> json) {
    return StockDaily(
      json['Date'],
      json['Open'],
      json['High'],
      json['Low'],
      json['Close'],
      json['Volume'],
      json['Change'],
    );
  }
}
