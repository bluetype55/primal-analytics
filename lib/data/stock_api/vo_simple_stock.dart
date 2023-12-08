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

  // static List<T> fromJsonList<T>(
  //   List<dynamic> jsonList,
  //   T Function(Map<String, dynamic>) fromJson, // 객체 생성을 위한 함수
  // ) {
  //   return jsonList.map((json) => fromJson(json)).toList();
  // }

  @override
  String toString() {
    return name;
  }
}
