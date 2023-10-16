import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> fetchItemNameByCode(String code) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('stocks')
        .doc(dotenv.env['stocks_document_id'])
        .collection('basic_info_for_all_items')
        .where('단축코드', isEqualTo: code)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['한글 종목약명'];
    } else {
      print('코드를 다시 확인하십시오.');
      return null;
    }
  }

  Future<String?> fetchCodeByItemName(String name) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('stocks')
        .doc(dotenv.env['stocks_document_id'])
        .collection('basic_info_for_all_items')
        .where('한글 종목약명', isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['단축코드'];
    } else {
      print('일치하는 주식이름이 없습니다.');
      return null;
    }
  }
}
