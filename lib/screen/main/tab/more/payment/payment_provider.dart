import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/favorite_provider.dart';

abstract mixin class PaymentProvider {
  final paymentController = Get.put(PaymentController());
}

class PaymentController extends GetxController with FavoriteProvider {
  var selectedBoxIndex = 0.obs; // 선택된 박스 인덱스
  var currentSubscriptIndex = 0.obs; //현재 구독중인 요금제 인덱스

  @override
  void onInit() {
    super.onInit();
    getCurrentSubscriptIndex();
  }

  void updateMaxFavoritesByCurrentIndex(int currentIndex) {
    if (currentIndex case 0) {
      favoriteController.updateMaxFavorites(5);
      favoriteController.adjustFavoritesList(5);
    } else if (currentIndex case 1) {
      favoriteController.updateMaxFavorites(15);
      favoriteController.adjustFavoritesList(15);
    } else if (currentIndex case 2) {
      favoriteController.updateMaxFavorites(30);
      favoriteController.adjustFavoritesList(30);
    } else {
      favoriteController.updateMaxFavorites(5);
      favoriteController.adjustFavoritesList(5);
    }
  }

  //현재 요금제 인덱스 가져오기
  Future<void> getCurrentSubscriptIndex() async {
    User? user = FirebaseAuth.instance.currentUser;
    //로그인 되어 있으면
    if (user != null) {
      String uid = user.uid;
      DocumentReference docRefUsers =
          FirebaseFirestore.instance.collection('users').doc(uid);
      var doc = await docRefUsers.get();
      //기존 문서가 있으면
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, int> currentSubMap =
            Map<String, int>.from(data['subscriptionState'] ?? {});
        int currentSubIndex;
        if (currentSubMap.isNotEmpty) {
          currentSubIndex = currentSubMap.entries.first.value;
        } else {
          currentSubIndex = 0; // 또는 기본값 지정
        }
        currentSubscriptIndex.value = currentSubIndex;
        selectedBoxIndex.value = currentSubIndex;
        updateMaxFavoritesByCurrentIndex(currentSubIndex);
      } else {
        // 기존 문서가 없으면
        currentSubscriptIndex.value = 0;
        selectedBoxIndex.value = 0;
        updateMaxFavoritesByCurrentIndex(0);
      }
    } else {
      //로그아웃 상태면
      currentSubscriptIndex.value = 0;
      selectedBoxIndex.value = 0;
      updateMaxFavoritesByCurrentIndex(0);
    }
  }

  //요금제 정보 저장하는 함수
  Future<void> saveCurrentSubscriptIndex(
      int currentSubIndex, BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    // 로그인 되어 있으면
    if (user != null) {
      String uid = user.uid;
      DocumentReference docRefUsers =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Firestore 문서 업데이트
      await docRefUsers.set({
        'subscriptionState': {'currentSubIndex': currentSubIndex}
      }, SetOptions(merge: true));
      currentSubscriptIndex.value = selectedBoxIndex.value;
      updateMaxFavoritesByCurrentIndex(selectedBoxIndex.value);
      context.showSnackbar('요금제가 변경되었습니다.');
    } else {
      // 로그인되지 않았으면 오류 메시지 또는 처리
      context.showErrorSnackbar("로그인이 필요합니다.");
      return;
    }
  }

  void selectBox(int index) {
    selectedBoxIndex.value = index;
  }

  void handleBasicPlan(BuildContext context) {
    if (currentSubscriptIndex.value != selectedBoxIndex.value) {
      saveCurrentSubscriptIndex(selectedBoxIndex.value, context);
    } else {
      context.showErrorSnackbar('이미 사용중인 요금제입니다.');
    }
  }

  void handleStandardPlan(BuildContext context) {
    if (currentSubscriptIndex.value != selectedBoxIndex.value) {
      saveCurrentSubscriptIndex(selectedBoxIndex.value, context);
    } else {
      context.showErrorSnackbar('이미 사용중인 요금제입니다.');
    }
  }

  void handleProPlan(BuildContext context) {
    if (currentSubscriptIndex.value != selectedBoxIndex.value) {
      saveCurrentSubscriptIndex(selectedBoxIndex.value, context);
    } else {
      context.showErrorSnackbar('이미 사용중인 요금제입니다.');
    }
  }
}
