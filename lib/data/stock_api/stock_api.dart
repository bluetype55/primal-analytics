import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:primal_analytics/common/util/local_json.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_daily.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';

mixin StockApi {
  String get baseUrl => dotenv.env['linux_server_api']!;

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
            '$baseUrl/stock_data_day?code=$code&start_date=2023-01-01&end_date=2023-05-30'));
      default:
        throw Exception("Please check StockApi method");
    }
    return LocalJson.fetchKoreanObjectList<T>(response);
  }
}
