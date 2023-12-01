import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

mixin StockApi {
  String get baseUrl => dotenv.env['linux_server_api']!;

  Future<List<T>> fetchStockData<T>(
      String market, T Function(Map<String, dynamic>) fromJson,
      [String? code]) async {
    final http.Response response;
    response = code == null
        ? await http.get(Uri.parse('$baseUrl/$market?start=0&end=100'))
        : await http.get(Uri.parse('$baseUrl/$market?code=$code'));

    if (response.statusCode == 200) {
      String resKorean = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = json.decode(resKorean.toString());
      return jsonResponse.map((json) => fromJson(json)).toList();
    } else {
      throw Exception("Failed to load stock data");
    }
  }
}
