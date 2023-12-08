import 'package:get/get.dart';

abstract mixin class DropdownProvider {
  late final DropdownController dropdownController =
      Get.put(DropdownController());
}

class DropdownController extends GetxController {
  List<String> koreanMarketDropdownMenuList = [
    'all',
    'KOSPI',
    'KOSDAQ',
    'KONEX'
  ];
  List<String> getSavedkoreanMarketDropdownMenuList() {
    return koreanMarketDropdownMenuList;
  }

  late final RxString koreanMarketselectedValue =
      koreanMarketDropdownMenuList[0].obs; // 선택된 항목을 Rx 상태로 관리

  void koreanMarketchangeSelectedValue(String? newValue) {
    if (newValue != null) {
      koreanMarketselectedValue.value = newValue;
    }
  }
}
