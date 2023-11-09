import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:primal_analytics/data/stock_api/stock_data.dart';

class StockApi {
  final String market;

  String baseUrl = dotenv.env['linux_server_api']!;

  StockApi({required this.market});

  Future<List<StockData>> fetchStockData() async {
    final response =
        await http.get(Uri.parse('$baseUrl/$market?start=0&end=100'));

    if (response.statusCode == 200) {
      String resKorean = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = json.decode(resKorean.toString());
      return StockData.fromJsonList(jsonResponse);
    } else {
      throw Exception("Failed to load stock data");
    }
  }
}
