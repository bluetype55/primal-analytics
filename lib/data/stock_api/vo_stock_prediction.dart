class StockPrediction {
  final String code;
  final String name;
  final String date;
  final int day1;
  final int day2;
  final int day3;
  final int day4;
  final int day5;

  StockPrediction(
    this.code,
    this.name,
    this.date,
    this.day1,
    this.day2,
    this.day3,
    this.day4,
    this.day5,
  );

  factory StockPrediction.fromJson(Map<String, dynamic> json) {
    return StockPrediction(
      json['code'],
      json['name'],
      json['date'],
      json['day1_pri'],
      json['day2_pri'],
      json['day3_pri'],
      json['day4_pri'],
      json['day5_pri'],
    );
  }
}
