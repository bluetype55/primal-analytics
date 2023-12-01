import 'package:get/get.dart';

abstract mixin class StockFilterProvider {
  late final StockFilterController stockFilter =
      Get.put(StockFilterController());
}

class StockFilterController extends GetxController {
  List<String> filterList = ['거래량', '상승폭', '하락폭', '시가총액'];

  late final RxString selectedFilter = filterList[0].obs; // GetX의 반응형 변수
  final RxString sortBy = 'amount'.obs;
  final RxBool ascending = false.obs;

  void selectFilter(String filter) {
    selectedFilter.value = filter;
    if (filter == filterList[0]) {
      sortBy.value = 'amount';
      ascending.value = false;
    } else if (filter == filterList[1]) {
      sortBy.value = 'changesRatio';
      ascending.value = false;
    } else if (filter == filterList[2]) {
      sortBy.value = 'changesRatio';
      ascending.value = true;
    } else if (filter == filterList[3]) {
      sortBy.value = 'marcap';
      ascending.value = false;
    } else {
      return;
    }
  }
}
