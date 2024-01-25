// GetxController를 확장하는 컨트롤러 클래스
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/finance_service.dart';

import '../../../../data/stock_api/vo_stock_data.dart';

abstract mixin class FavoriteProvider {
  // Get.put()을 사용하여 FavoriteController 인스턴스를 생성 및 사용
  final FavoriteController favoriteController = Get.find<FavoriteController>();
}

class FavoriteController extends GetxController with FinanceServiceProvider {
  var isFavorite = false.obs;
  var favoriteStockList = Rxn<List<StockData>>();
  var watchStocklist = Rxn<List<StockData>>();
  var maxFavorites = 5.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadInitialData();
  }

  // 비동기 작업 최적화
  Future<void> loadInitialData() async {
    await finService.ensureDataLoaded();
    await getFavoritesList();
    await getSortedWatchlist();
  }

  // 최대 즐겨찾기 개수를 업데이트하는 메서드
  void updateMaxFavorites(int newMax) {
    maxFavorites.value = newMax;
    // 필요한 경우, 현재 즐겨찾기 목록을 새 최대 개수에 맞게 조정할 수 있음
  }

  //관심목록에 저장
  Future<void> addMyWatchlist(String code) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // 로그인된 사용자의 UID를 사용하여 문서 참조 생성
      String uid = user.uid;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      var doc = await docRef.get();
      if (doc.exists) {
        // 기존 문서가 있으면 데이터 업데이트
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, int> watchlist =
            Map<String, int>.from(data['watchlist'] ?? {});

        // 조회 횟수 업데이트
        watchlist[code] = (watchlist[code] ?? 0) + 1;

        // Firestore 문서 업데이트
        await docRef.update({'watchlist': watchlist});
        getSortedWatchlist();
      } else {
        // 새 문서 생성
        await docRef.set({
          'watchlist': {code: 1}
        });
        getSortedWatchlist();
      }
    }
  }

  //관심목록 가져오기
  Future<void> getSortedWatchlist() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      var doc = await docRef.get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, int> datalist =
            Map<String, int>.from(data['watchlist'] ?? {});

        //stock 형식으로 바꿔서 리스트에 저장
        var tempStockList = <Map<String, dynamic>>[];
        for (var entry in datalist.entries) {
          var code = entry.key;
          var views = entry.value;
          StockData? stockData =
              finService.findingDataWithCode<StockData>(code);
          if (stockData != null) {
            tempStockList.add({'stockData': stockData, 'views': views});
          }
        }
        // tempStockList를 views 값에 따라 다시 정렬
        tempStockList.sort((a, b) => b['views'].compareTo(a['views']));

        // 최종적으로 StockData 객체만 추출하여 리스트에 저장
        var finalStockList =
            tempStockList.map((e) => e['stockData'] as StockData).toList();
        watchStocklist.value = finalStockList;
      } else {
        watchStocklist.value = []; // 문서가 없는 경우
      }
    } else {
      watchStocklist.value = [];
    }
  }

  //찜 목록에 저장
  Future<void> toggleFavorite(String code, BuildContext context) async {
    // 현재 로그인된 사용자 가져오기
    User? user = FirebaseAuth.instance.currentUser;

    // 사용자가 로그인되어 있는지 확인
    if (user != null) {
      // 로그인된 사용자의 UID
      String uid = user.uid;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Firestore에서 현재 상태를 조회
      var doc = await docRef.get();
      if (doc.exists) {
        var data = doc.data();
        if (data is Map<String, dynamic>) {
          // 데이터를 Map<String, dynamic>으로 캐스팅
          List<dynamic> favorites = List.from(data['favorites'] ?? []);
          if (favorites.contains(code)) {
            // 즐겨찾기 취소
            favorites.remove(code);
            isFavorite.value = false;
          } else {
            // 즐겨찾기 추가 전 최대 개수 확인
            if (favorites.length >= maxFavorites.value) {
              context.showErrorSnackbar('찜 목록 제한 숫자에 도달했습니다.');
              return;
            }
            favorites.add(code);
            isFavorite.value = true;
          }
          // Firestore 문서 업데이트
          await docRef.update({'favorites': favorites});
          getFavoritesList();
        }
      } else {
        // 즐겨찾기 문서가 없는 경우 새로 생성
        await docRef.set({
          'favorites': [code]
        });
        isFavorite.value = true;
        getFavoritesList();
      }
    } else {
      context.showErrorSnackbar('로그인이 필요합니다.');
    }
  }

  // 즐겨찾기 목록 조절 메서드
  Future<void> adjustFavoritesList(int maxFavorites) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      var doc = await docRef.get();
      if (doc.exists) {
        var data = doc.data();
        if (data is Map<String, dynamic>) {
          List<dynamic> favorites = List.from(data['favorites'] ?? []);
          while (favorites.length > maxFavorites) {
            // 최대 개수를 초과하는 경우 가장 오래된 항목 제거
            favorites.removeAt(0);
          }
          // Firestore 문서 업데이트
          await docRef.update({'favorites': favorites});
          getFavoritesList();
        }
      }
    }
  }

  //찜 목록 가져오기
  Future<void> getFavoritesList() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      var doc = await docRef.get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // 즐겨찾기 리스트를 가져옵니다. 존재하지 않는 경우 빈 리스트를 반환합니다.
        List<String> datalist = List<String>.from(data['favorites'] ?? []);

        var tempStockList = <StockData>[];

        for (var code in datalist) {
          StockData? stockData =
              finService.findingDataWithCode<StockData>(code);
          if (stockData != null) {
            tempStockList.add(stockData);
          }
        }

        // 이미 List<String> 형태이므로, 추가적인 변환은 필요하지 않습니다.
        favoriteStockList.value = tempStockList.reversed.toList();
      } else {
        favoriteStockList.value = []; // 문서가 없는 경우 빈 맵 반환
      }
    } else {
      favoriteStockList.value = [];
    }
  }

  // 특정 컬렉션에 code가 있는지 확인
  Future<bool> checkIfCodeExists(String code) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      var doc = await docRef.get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> codes = data['favorites'] as List<dynamic>;
        return codes.contains(code);
      }
    }
    return false;
  }

  // 즐겨찾기 상태 확인 및 업데이트
  Future<void> checkFavoriteStatus(String code) async {
    isFavorite.value = await checkIfCodeExists(code);
  }
}
