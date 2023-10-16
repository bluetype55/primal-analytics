import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String _apiKey = dotenv.env['public_data_portal_encoding_key']!;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  http.Response res = await httpGetConnection();

  print("HTTP 응답 코드: ${res.statusCode}");
  print("HTTP 응답 데이터: ${res.body}");
}

Future<http.Response> httpGetConnection() async {
  final response = await http.get(
    Uri.parse(
        'https://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo?'
        'serviceKey=$_apiKey' // api_key
        '&numOfRows=200' // 최대 데이터
        '&pageNo=1' // 페이지 넘버
        '&resultType=json' // 구분(xml, json) Default: xml
        '&endBasDt=20201006' // 기준일자가 검색값보다 작은 데이터를 검색
        '&itmsNm=' //검색값과 종목명이 일치하는 데이터를 검색
        '&likeItmsNm=삼성' //종목명이 검색값을 포함하는 데이터를 검색
        '&mrktCls=KOSPI' // 검색값과 시장구분이 일치하는 데이터를 검색
        ),
  );
  return response;
}
