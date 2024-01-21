class StockFinance {
  final String code;
  final String eps;
  final String per;
  final String fwdEps;
  final String fwdPer;
  final String bps;
  final String pbr;
  final int dps;
  final double dividendYield;

  StockFinance(
    this.code,
    this.eps,
    this.per,
    this.fwdEps,
    this.fwdPer,
    this.bps,
    this.pbr,
    this.dps,
    this.dividendYield,
  );

  factory StockFinance.fromJson(Map<String, dynamic> json) {
    return StockFinance(
      json['종목코드'],
      json['EPS'],
      json['PER'],
      json['선행 EPS'],
      json['선행 PER'],
      json['BPS'],
      json['PBR'],
      json['주당배당금'],
      json['배당수익률'],
    );
  }

  @override
  String toString() {
    return '$code per: $per';
  }
}
