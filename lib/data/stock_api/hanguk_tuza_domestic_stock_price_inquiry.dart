import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'https://openapi.koreainvestment.com:9443';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // String accessToken = await getAccessToken();
  // print(accessToken);
  String accessToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6IjQwMDljNDA3LTBkYzktNGIxMy1hZWVmLWEzNmZlOTUzYmE0YyIsImlzcyI6InVub2d3IiwiZXhwIjoxNjk2ODA4NjIwLCJpYXQiOjE2OTY3MjIyMjAsImp0aSI6IlBTb0psa1VVRENJN0E5QUNyOHhWSXFramt0TTNwNmRzZlBydCJ9.oX_eOB5_082wU3TC358Sx27QHGzEWAMnMDKPGVCCKN6-oNpc59HyrBeMciLEQTOvkiPTCdFl5ZT21w4RPkQKug';

  final data = {
    "fid_cond_mrkt_div_code": "J",
    "fid_input_iscd": "095570",
  };
  final Uri url = Uri.https(
    "openapi.koreainvestment.com:9443",
    "/uapi/domestic-stock/v1/quotations/inquire-price",
    data,
  );
  const trId = "FHKST01010100";

  try {
    final response = await httpPostBodyConnection(url, data, trId, accessToken);
    //final response = await httpGetConnection();
    String resKr = utf8.decode(response.bodyBytes);
    Map<String, dynamic> jsonKrMap = json.decode(resKr.toString());
    print("HTTP 응답 코드: ${response.statusCode}");
    print("HTTP 응답 데이터: $jsonKrMap");

    print('종목명: ${jsonKrMap["output"]["stck_prpr"]}');
  } catch (e) {
    print("에러 발생: $e");
  }
}

Future<http.Response> httpPostBodyConnection(
    Uri url, Map<String, String> data, String trId, String accessToken) async {
  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "authorization": "Bearer $accessToken",
      "appKey": dotenv.env['hanguk_tuza_app_key']!,
      "appSecret": dotenv.env['hanguk_tuza_app_secret']!,
      "tr_id": trId,
    },
    body: jsonEncode(data),
  );

  return response;
}

Future<String> getAccessToken() async {
  final headers = {"content-type": "application/json"};
  final body = {
    "grant_type": "client_credentials",
    "appkey": dotenv.env['hanguk_tuza_app_key']!,
    "appsecret": dotenv.env['hanguk_tuza_app_secret']!,
  };
  const path = "oauth2/tokenP";
  final url = Uri.parse("$_baseUrl/$path");

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    final accessToken = jsonDecode(response.body)["access_token"];
    return accessToken;
  } else {
    throw Exception("Failed to get access token");
  }
}
