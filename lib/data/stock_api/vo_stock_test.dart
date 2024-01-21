class StockTest {
  final String code;
  final String date;
  final double actual;
  final double predicted;

  StockTest(
    this.code,
    this.date,
    this.actual,
    this.predicted,
  );

  factory StockTest.fromJson(Map<String, dynamic> json) {
    return StockTest(
      json['code'],
      json['date'],
      json['actual'],
      json['predicted'],
    );
  }
}
