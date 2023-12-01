import 'package:get/get.dart';

import 'dropdown_menu_list.dart';

class DropdownController extends GetxController {
  var koreanMarketselectedValue =
      koreanMarketDropdownMenuList[0].obs; // 선택된 항목을 Rx 상태로 관리

  void koreanMarketchangeSelectedValue(String? newValue) {
    if (newValue != null) {
      koreanMarketselectedValue.value = newValue;
    }
  }
}
