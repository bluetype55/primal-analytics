import 'package:charset_converter/charset_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WebCrawler {
  Future<List<List<dynamic>>> fetchDataAndSaveToFile() async {
    var genOtpUrl = Uri.parse(dotenv.env['gen_otp_url']!);
    var downUrl = Uri.parse(dotenv.env['down_url']!);
    var genOtpData = {
      'locale': 'ko_KR',
      'mktId': 'ALL', // 시장구분
      'share': '1',
      'csvxls_isNo': 'false', //파일 형식 false = csv, true= xls
      'name': 'fileDown',
      'url': dotenv.env['gen_otp_data_url'],
    };

    var headers = {
      'Referer': dotenv.env['request_header_referer']!, // 리퍼러 설정
    };

    var response =
        await http.post(genOtpUrl, body: genOtpData, headers: headers);

    String otp = response.body.toString();

    var downSectorKs =
        await http.post(downUrl, body: {'code': otp}, headers: headers);

    String decodedData =
        await CharsetConverter.decode("EUC-KR", downSectorKs.bodyBytes);

    final List<List<dynamic>> rows =
        const CsvToListConverter(eol: '\n', fieldDelimiter: ',')
            .convert(decodedData);

    return rows;
  }

  Future<void> saveToFirestore(List<List<dynamic>> rows) async {
    final FirebaseFirestore fstore = FirebaseFirestore.instance;

    DocumentReference doc =
        fstore.collection('stocks').doc(dotenv.env['stocks_document_id']!);

    List<dynamic> headers = rows[0];

    for (int i = 1; i < rows.length; i++) {
      Map<String, dynamic> data = {};
      for (int j = 0; j < headers.length; j++) {
        data[headers[j]] = rows[i][j];
      }
      await doc.collection('basic_info_for_all_items').add(data);
    }
  }
}
