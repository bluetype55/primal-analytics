import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/dialog/d_confirm.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/favorite_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    listenToPurchaseUpdates();
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
  Future<void> saveCurrentSubscriptIndex(int currentSubIndex) async {
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
      currentSubscriptIndex.value = currentSubIndex;
      selectedBoxIndex.value = currentSubIndex;
      updateMaxFavoritesByCurrentIndex(currentSubIndex);
      print('요금제가 변경되었습니다.');
    } else {
      // 로그인되지 않았으면 오류 메시지 또는 처리
      print("로그인이 필요합니다.");
      return;
    }
  }

  void selectBox(int index) {
    selectedBoxIndex.value = index;
  }

  void handleBasicPlan(BuildContext context) {
    if (currentSubscriptIndex.value != selectedBoxIndex.value) {
      showDialog(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            message:
                '이미 사용중인 요금제가 있습니다. 요금제를 변경하시려면 먼저 구독관리 페이지로 이동 후, 기존 요금제를 취소하시고 남은 이용 기간이 종료되면 변경하실 수 있습니다. 구독관리 페이지로 이동하시겠습니까?',
            confirmButtonText: '이동',
            cancelButtonText: '취소',
            function: () {
              openSubscriptionManagementPage(context);
              Nav.pop(context);
            },
            cancelFunction: () {
              Nav.pop(context);
            },
          );
        },
      );
    } else {
      context.showErrorSnackbar('이미 사용중인 요금제입니다.');
    }
  }

  void handleStandardPlan(BuildContext context) async {
    if (currentSubscriptIndex.value != selectedBoxIndex.value) {
      if (currentSubscriptIndex.value == 2) {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmDialog(
              message:
                  '이미 Pro 요금제를 사용중입니다. 요금제를 변경하시려면 먼저 구독관리 페이지로 이동 후, 기존 요금제를 취소하시고 남은 이용 기간이 종료되면 변경하실 수 있습니다. 구독관리 페이지로 이동하시겠습니까?',
              confirmButtonText: '이동',
              cancelButtonText: '취소',
              function: () {
                openSubscriptionManagementPage(context);
                Nav.pop(context);
              },
              cancelFunction: () {
                Nav.pop(context);
              },
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmDialog(
              message:
                  '이 앱에서 제공하는 AI 서비스는 정확도가 매우 낮습니다. 무료 서비스로 이용하시는 것을 권장합니다. 그래도 구매하시겠습니까?',
              confirmButtonText: '구매',
              cancelButtonText: '취소',
              function: () {
                Nav.pop(context);
                purchaseProdById('primal_analytics_standard');
                listenToPurchaseUpdates();
              },
              cancelFunction: () {
                Nav.pop(context);
              },
            );
          },
        );
      }
    } else {
      context.showErrorSnackbar('이미 사용중인 요금제입니다.');
    }
  }

  void handleProPlan(BuildContext context) async {
    if (currentSubscriptIndex.value != selectedBoxIndex.value) {
      if (currentSubscriptIndex.value == 1) {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmDialog(
              message:
                  '이미 Standard 요금제를 사용중입니다. 요금제를 변경하시려면 먼저 구독관리 페이지로 이동 후, 기존 요금제를 취소하시고 남은 이용 기간이 종료되면 변경하실 수 있습니다. 구독관리 페이지로 이동하시겠습니까?',
              confirmButtonText: '이동',
              cancelButtonText: '취소',
              function: () {
                openSubscriptionManagementPage(context);
                Nav.pop(context);
              },
              cancelFunction: () {
                Nav.pop(context);
              },
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmDialog(
              message:
                  '이 앱에서 제공하는 AI 서비스는 정확도가 매우 낮습니다. 무료 서비스로 이용하시는 것을 권장합니다. 그래도 구매하시겠습니까?',
              confirmButtonText: '구매',
              cancelButtonText: '취소',
              function: () {
                Nav.pop(context);
                purchaseProdById('primal_analytics_pro');
                listenToPurchaseUpdates();
              },
              cancelFunction: () {
                Nav.pop(context);
              },
            );
          },
        );
      }
    } else {
      context.showErrorSnackbar('이미 사용중인 요금제입니다.');
    }
  }

  //상품 아이디로 결제
  Future<void> purchaseProdById(String kId) async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      print('purchaseProdById(): Play Store를 사용할 수 없습니다.');
      return;
    }

    // 구매 가능한 상품 조회
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails({kId});
    if (response.notFoundIDs.isNotEmpty) {
      print('상품을 찾을 수 없습니다.');
      return;
    }

    List<ProductDetails> products = response.productDetails;
    if (products.isEmpty) {
      print('상품 정보가 없습니다.');
      return;
    }
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: products[0]);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  //구매 완료 확인
  void listenToPurchaseUpdates() {
    final Stream<List<PurchaseDetails>> purchaseUpdates =
        InAppPurchase.instance.purchaseStream;
    print('purchaseUpdates: $purchaseUpdates');

    purchaseUpdates.listen(
      (purchaseDetailsList) {
        for (var purchaseDetails in purchaseDetailsList) {
          if (purchaseDetails is GooglePlayPurchaseDetails) {
            // Google Play 구매 상세 정보 처리
            GooglePlayPurchaseDetails googlePlayPurchaseDetails =
                purchaseDetails;
            // 여기서 googlePlayPurchaseDetails를 사용하여 추가 작업을 수행
            print(
                'googlePlayPurchaseDetails: ${googlePlayPurchaseDetails.productID}');
          }
          if (purchaseDetails.status == PurchaseStatus.purchased) {
            // 구매가 성공적으로 완료된 경우
            if (purchaseDetails.productID == 'primal_analytics_standard') {
              selectedBoxIndex.value = 1;
              saveCurrentSubscriptIndex(selectedBoxIndex.value);
            } else if (purchaseDetails.productID == 'primal_analytics_pro') {
              selectedBoxIndex.value = 2;
              saveCurrentSubscriptIndex(selectedBoxIndex.value);
            } else {
              selectedBoxIndex.value = 0;
              saveCurrentSubscriptIndex(selectedBoxIndex.value);
            }
            print("구매 완료: ${purchaseDetails.productID}");
          } else if (purchaseDetails.status == PurchaseStatus.pending) {
            // 구매가 보류 중인 경우
            print('구매보류');
          } else if (purchaseDetails.status == PurchaseStatus.error) {
            // 구매 중 오류가 발생한 경우
            print('구매오류');
          } else if (purchaseDetails.status == PurchaseStatus.canceled) {
            // 구매가 사용자에 의해 취소된 경우
            print('구매취소');
          }
          // 필요한 경우 추가 상태 처리
        }
      },
    );
  }

  /// 사용자의 구독 관리 페이지로 이동합니다.
  Future<void> openSubscriptionManagementPage(BuildContext context) async {
    final String url;

    // 플랫폼에 따라 URL을 결정합니다.
    if (Theme.of(context).platform == TargetPlatform.android) {
      // Google Play Store의 구독 관리 페이지 URL
      url = 'https://play.google.com/store/account/subscriptions';
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      // Apple App Store의 구독 관리 페이지 URL
      url = 'https://apps.apple.com/account/subscriptions';
    } else {
      // 다른 플랫폼의 경우 처리
      throw 'Unsupported platform';
    }

    // URL을 브라우저에서 열기
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  //현재 구독중인 상품 가져오기
  Future<void> fetchPastPurchases() async {
    final InAppPurchase iap = InAppPurchase.instance;

    // 인앱 구매 가능 여부 확인
    final bool available = await iap.isAvailable();
    if (!available) {
      // 인앱 구매 불가능한 경우
      print('인앱 구매를 사용할 수 없습니다.');
      return;
    }
    // 과거 구매 내역 조회
    final InAppPurchaseAndroidPlatformAddition androidPlatform =
        iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    final QueryPurchaseDetailsResponse pastPurchases =
        await androidPlatform.queryPastPurchases();
    if (pastPurchases.error != null) {
      // 과거 구매 내역 조회 중 오류 발생
      print('과거 구매 내역 조회 중 오류 발생: ${pastPurchases.error}');
      saveCurrentSubscriptIndex(0);
      return;
    } else if (pastPurchases.pastPurchases.isEmpty) {
      print('과거 구매 내역이 없습니다: ${pastPurchases.pastPurchases}');
      saveCurrentSubscriptIndex(0);
    }
    // 과거 구매 내역 처리
    for (final PurchaseDetails purchase in pastPurchases.pastPurchases) {
      // 여기서 각 구매 내역을 처리합니다.
      switch (purchase.productID) {
        case 'primal_analytics_standard':
          saveCurrentSubscriptIndex(1);
        case 'primal_analytics_pro':
          saveCurrentSubscriptIndex(2);
        default:
          saveCurrentSubscriptIndex(0);
      }
      print('purchase.productID: ${purchase.productID}');
      print('purchase.transactionDate: ${purchase.transactionDate}');
      print('purchase.status: ${purchase.status}');
      print(
          'purchase.pendingCompletePurchase: ${purchase.pendingCompletePurchase}');
      // 예: if (purchase.status == PurchaseStatus.purchased) { ... }
    }
  }

  Future<void> changeSubscription(GooglePlayPurchaseDetails oldPurchaseDetails,
      ProductDetails newProductDetails) async {
    final GooglePlayPurchaseParam purchaseParam = GooglePlayPurchaseParam(
        productDetails: newProductDetails,
        changeSubscriptionParam: ChangeSubscriptionParam(
            oldPurchaseDetails: oldPurchaseDetails,
            prorationMode: ProrationMode.immediateWithTimeProration));

    final bool success = await InAppPurchase.instance
        .buyNonConsumable(purchaseParam: purchaseParam);
    if (success) {
      print("구독이 성공적으로 변경되었습니다.");
    } else {
      print("구독 변경에 실패했습니다.");
    }
  }
}
