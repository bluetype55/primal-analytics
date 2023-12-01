class SimpleStock {
  final String name;
  final String market;
  final String code;

  SimpleStock(
    this.name,
    this.market,
    this.code,
  );

  factory SimpleStock.fromJson(Map<String, dynamic> json) {
    return SimpleStock(
      json['Name'],
      json['Market'],
      json['Code'],
    );
  }

  static List<SimpleStock> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((data) => SimpleStock.fromJson(data)).toList();
  }

  @override
  String toString() {
    return name;
  }
}
