class StockIndustryInfo {
  final String name;
  final String code;
  final String industry;
  final String mainProduct;
  final String listingDate;
  final String fiscalYearEnd;
  final String ceo;
  final String webSite;
  final String location;

  StockIndustryInfo(
    this.name,
    this.code,
    this.industry,
    this.mainProduct,
    this.listingDate,
    this.fiscalYearEnd,
    this.ceo,
    this.webSite,
    this.location,
  );

  factory StockIndustryInfo.fromJson(Map<String, dynamic> json) {
    return StockIndustryInfo(
      json['회사명'],
      json['종목코드'],
      json['업종'],
      json['주요제품'],
      json['상장일'],
      json['결산월'],
      json['대표자명'],
      json['홈페이지'],
      json['지역'],
    );
  }

  static List<T> fromJsonList<T>(
    List<dynamic> jsonList,
    T Function(Map<String, dynamic>) fromJson, // 객체 생성을 위한 함수
  ) {
    return jsonList.map((json) => fromJson(json)).toList();
  }

  @override
  String toString() {
    return '$name $industry';
  }
}
