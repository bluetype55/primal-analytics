class SimpleStockDispose {
  final String name;

  SimpleStockDispose(this.name);

  factory SimpleStockDispose.fromJson(dynamic json) {
    return SimpleStockDispose(json['name']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}
