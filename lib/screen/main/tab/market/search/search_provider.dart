import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:primal_analytics/common/dart/extension/datetime_extension.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';

import '../../../../../data/stock_api/finance_service.dart';
import '../../../../../data/stock_api/vo_stock_data.dart';

abstract mixin class SearchProvider {
  final searchDataController = Get.find<SearchDataController>();
}

class SearchDataController extends GetxController with FinanceServiceProvider {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<StockData> stocks = [];
  RxList<StockData> autoCompleteStocksList = <StockData>[].obs;
  List<StockIndustryInfo> stocksInfo = [];
  RxList<StockIndustryInfo> autoCompleteIndustryList =
      <StockIndustryInfo>[].obs;
  RxList<StockData> searchHistoryList = <StockData>[].obs;
  RxList<StockData> popularStockList = <StockData>[].obs;
  RxList<String> popularKeywordList = <String>[].obs;
  final TextEditingController keywordController = TextEditingController();

  @override
  void onInit() {
    keywordController.addListener(() {
      search(keywordController.text);
    });
    loadStockDataList();
    getHistory();
    super.onInit();
  }

  Future<void> loadStockDataList() async {
    final jsonList = finService.krxStockDataList.value;
    if (jsonList != null) {
      stocks.addAll(jsonList);
    }
  }

  void search(String keyword) {
    if (keyword.isEmpty) {
      print('키워드가 없습니다');
      autoCompleteStocksList.clear();
      return;
    } else {
      autoCompleteStocksList.value = stocks
          .where((element) => getRegExp(
                keyword,
                const RegExpOptions(
                  initialSearch: true,
                  ignoreSpace: true,
                  ignoreCase: true,
                  fuzzy: true,
                  global: true,
                ),
              ).hasMatch(element.name))
          .toList();
    }
  }

  // 주식 조회 정보를 저장하는 메서드
  Future<void> saveStockView(StockData stock) async {
    // 현재 날짜를 문자열 형태로 가져옵니다.
    String currentDate = DateTime.now().formattedDate;

    // 'stockViews' 컬렉션 내의 현재 날짜의 문서 참조를 가져옵니다.
    DocumentReference dateDocRef =
        firestore.collection('stockViews').doc('날짜별');

    // 문서를 가져와서 이미 존재하는지 확인합니다.
    var doc = await dateDocRef.get();
    if (doc.exists) {
      // 문서가 이미 존재하면 데이터를 업데이트합니다.
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<String, int> viewData =
          Map<String, int>.from(data[currentDate] ?? {});
      // 조회 횟수 업데이트
      viewData[stock.code] = (viewData[stock.code] ?? 0) + 1;

      // Firestore 문서 업데이트
      await dateDocRef.update({currentDate: viewData});
    } else {
      // 문서가 존재하지 않으면 새로운 문서를 생성합니다.
      await dateDocRef.set({
        currentDate: {stock.code: 1}
      });
    }
    getTodayStockRaking();
  }

  //주식 조회 정보를 가져오기
  Future<void> getTodayStockRaking() async {
    DocumentReference dateDocRef =
        FirebaseFirestore.instance.collection('stockViews').doc('날짜별');

    DateTime currentDate = DateTime.now();
    Map<String, dynamic> data;
    Map<String, int> datalist = {};

    for (int i = 0; i < 3; i++) {
      // 오늘, 전날, 그 전날까지 확인
      String dateString = currentDate.subtract(Duration(days: i)).formattedDate;
      var doc = await dateDocRef.get();
      if (doc.exists) {
        data = doc.data() as Map<String, dynamic>;
        if (data.containsKey(dateString)) {
          datalist = Map<String, int>.from(data[dateString]);
          break; // 데이터를 찾으면 반복문을 종료합니다.
        }
      }
    }

    if (datalist.isNotEmpty) {
      // stock 형식으로 바꿔서 리스트에 저장
      var tempStockList = <Map<String, dynamic>>[];
      for (var entry in datalist.entries) {
        var code = entry.key;
        var views = entry.value;
        StockData? stockData = finService.findingDataWithCode<StockData>(code);
        if (stockData != null) {
          tempStockList.add({'stockData': stockData, 'views': views});
        }
      }
      // tempStockList를 views 값에 따라 다시 정렬
      tempStockList.sort((a, b) => b['views'].compareTo(a['views']));
      // 최종적으로 StockData 객체만 추출하여 리스트에 저장
      var finalStockList =
          tempStockList.map((e) => e['stockData'] as StockData).toList();
      popularStockList.value = finalStockList;
    } else {
      popularStockList.value = []; // 이전 3일간 데이터가 없는 경우
    }
  }

  Future<void> addHistory(StockData stock) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference userDocRef = firestore.collection('users').doc(uid);
      var doc = await userDocRef.get();

      if (doc.exists) {
        var data = doc.data();
        if (data != null && data is Map<String, dynamic>) {
          List<dynamic> searchHistoryList = List.from(data['history'] ?? []);

          // 기존에 동일한 항목이 있으면 제거
          searchHistoryList.remove(stock.code);

          // 새 항목 추가
          searchHistoryList.add(stock.code);

          // 리스트 크기가 20을 초과하면 가장 오래된 요소 제거
          if (searchHistoryList.length > 20) {
            searchHistoryList.removeAt(0);
          }

          // Firestore에 업데이트
          await userDocRef.update({'history': searchHistoryList});
          getHistory();
        }
      } else {
        // 문서가 없으면 새로운 문서 생성
        await userDocRef.set({
          'history': [stock.code]
        });
      }
    }
  }

  // 사용자의 히스토리를 가져오는 메서드
  Future<void> getHistory() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      DocumentReference userDocRef = firestore.collection('users').doc(uid);

      var doc = await userDocRef.get();
      if (doc.exists) {
        var data = doc.data();
        if (data != null && data is Map<String, dynamic>) {
          // Firestore 문서에서 'history' 필드의 데이터를 가져옴
          List<String> dataList = List<String>.from(data['history'] ?? []);
          var stockList = <StockData>[];
          for (var code in dataList) {
            StockData? stockData =
                finService.findingDataWithCode<StockData>(code);
            if (stockData != null) {
              stockList.add(stockData);
            }
          }
          searchHistoryList.value = stockList;
        }
      }
    }
  }

  void removeHistory(StockData stock) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference userDocRef = firestore.collection('users').doc(uid);

      var doc = await userDocRef.get();
      if (doc.exists) {
        var data = doc.data();
        if (data != null && data is Map<String, dynamic>) {
          List<dynamic> searchHistoryList = List.from(data['history'] ?? []);

          // 특정 code 요소 삭제
          searchHistoryList.remove(stock.code);

          // Firestore에 업데이트
          await userDocRef.update({'history': searchHistoryList});
          getHistory();
        }
      }
    }
  }

  void removeAllHistory() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference userDocRef = firestore.collection('users').doc(uid);

      // Firestore 문서의 history 필드를 빈 리스트로 업데이트
      await userDocRef.update({'history': []});
      getHistory();
    }
  }
}
