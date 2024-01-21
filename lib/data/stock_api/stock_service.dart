import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:primal_analytics/common/util/local_json.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_daily.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_finance.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_prediction.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_test.dart';

mixin StockService {
  String get baseUrl => dotenv.env['linux_server_api']!;
  String get apiKey => dotenv.env['linux_server_api_key']!;

  Future<List<T>> fetchMarketData<T>(String market) async {
    final http.Response response;
    response = await http.get(Uri.parse('$baseUrl/$market?start=0&end=100'));

    return LocalJson.fetchKoreanObjectList<T>(response);
  }

  Future<List<T>> codeToData<T>(String code, [String? market]) async {
    String marketValue = market ?? "krx";
    final http.Response response;
    switch (T) {
      case StockData:
        response =
            await http.get(Uri.parse('$baseUrl/$marketValue?code=$code'));
      case StockIndustryInfo:
        response = await http.get(Uri.parse('$baseUrl/sector?code=$code'));
      case StockDaily:
        response = await http.get(Uri.parse(
            '$baseUrl/stock_data_day?code=$code&start_date=2021-11-01&end_date=2023-12-01'));
      case StockTest:
        response = await http.get(Uri.parse(
            '$baseUrl/get_testData?code=$code&start_date=2023-11-01&end_date=2023-12-01'));
      case StockPrediction:
        response = await http.post(
          Uri.parse('$baseUrl/get_prediction'),
          headers: {
            'Content-Type': 'application/json',
            'X-API-Key': apiKey,
          },
          body: json.encode({'code': code}),
        );
      case StockFinance:
        response = await http.get(Uri.parse('$baseUrl/PerPbr?code=$code'));
      default:
        throw Exception("Please check StockApi method");
    }
    return LocalJson.fetchKoreanObjectList<T>(response);
  }
}
