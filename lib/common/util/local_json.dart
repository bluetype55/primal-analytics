import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:primal_analytics/data/news_api/vo_news_data.dart';
import 'package:primal_analytics/data/stock_api/vo_simple_stock.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_daily.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_finance.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_prediction.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_test.dart';

import '../../screen/main/tab/more/opensource/vo_package.dart';

class LocalJson {
  static Future<List<T>> fetchObjectList<T>(http.Response response) async {
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => _tryConverting<T>(json)).toList();
    } else {
      throw Exception("Failed to load stock data");
    }
  }

  static Future<List<T>> fetchKoreanObjectList<T>(
      http.Response response) async {
    if (response.statusCode == 200) {
      String resKorean = utf8.decode(response.bodyBytes);
      var jsonData = json.decode(resKorean);

      // jsonData가 Map인지 확인
      if (jsonData is Map<String, dynamic>) {
        if (jsonData.containsKey('articles') &&
            jsonData['articles'] is List<dynamic>) {
          List<dynamic> jsonResponse = jsonData['articles'];
          return jsonResponse.map((json) => _tryConverting<T>(json)).toList();
        } else {
          // 'articles' 키가 없는 경우의 처리 (예: 빈 리스트 반환)
          return <T>[];
        }
      } else {
        // jsonData가 List인 경우 또는 다른 타입인 경우의 처리
        List<dynamic> jsonResponse = jsonData;
        return jsonResponse.map((json) => _tryConverting<T>(json)).toList();
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<T> getObject<T>(String filePath) async {
    final string = await getJsonString(filePath);
    final json = jsonDecode(string);
    return _tryConverting(json);
  }

  static Future<List<T>> getObjectList<T>(String filePath) async {
    final string = await getJsonString(filePath);
    final json = jsonDecode(string);
    if (json is List) {
      return json.map<T>((e) => _tryConverting(e)).toList();
    }
    return [];
  }

  static dynamic getJson(String filePath) async {
    final string = await getJsonString(filePath);
    return jsonDecode(string);
  }

  static Future<String> getJsonString(String filePath) async {
    return await rootBundle.loadString('assets/$filePath');
  }
}

T _tryConverting<T>(dynamic json) {
  switch (T) {
    case Package:
      return Package.fromJson(json) as T;
    case SimpleStock:
      return SimpleStock.fromJson(json) as T;
    case StockData:
      return StockData.fromJson(json) as T;
    case StockIndustryInfo:
      return StockIndustryInfo.fromJson(json) as T;
    case StockDaily:
      return StockDaily.fromJson(json) as T;
    case StockTest:
      return StockTest.fromJson(json) as T;
    case StockPrediction:
      return StockPrediction.fromJson(json) as T;
    case StockFinance:
      return StockFinance.fromJson(json) as T;
    case NewsData:
      return NewsData.fromJson(json) as T;
    default:
      throw Exception("Please check _tryConverting method");
  }
}
