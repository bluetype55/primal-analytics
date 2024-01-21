import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

Future<Widget> connectToMysql() async {
  // 데이터베이스 설정
  final pool = MySQLConnectionPool(
    host: '', // MySQL 서버 주소
    port: 3306, // MySQL 서버 포트, 기본값은 3306
    userName: '', // 사용자 이름
    password: '', // 비밀번호
    maxConnections: 10,
    databaseName: '', // 데이터베이스 이름
  );

  try {
    // 쿼리 실행
    var results = await pool.execute(
        'SELECT image1 FROM Hi_img WHERE code = :code', {"code": '005930'});
    print(results.toString());
    var str = convertBase64StringToUint8List(
        results.rows.first.assoc().entries.first.value);
    // 결과 처리
    if (str != null) {
      print(str);
      return imageFromBlob(str);
    } else {
      Container();
    }
  } catch (e) {
    print('Error connecting to MySQL: $e');
  }
  return Container();
}

Widget imageFromBlob(Uint8List blobData) {
  return Image.memory(blobData);
}

Uint8List? convertBase64StringToUint8List(String? base64String) {
  if (base64String != null) {
    return base64.decode(base64String);
  }
  return null;
}
