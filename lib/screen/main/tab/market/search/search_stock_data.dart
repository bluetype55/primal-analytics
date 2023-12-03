import 'package:get/get.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';

import '../../../../../data/stock_api/stock_service.dart';
import '../../../../../data/stock_api/vo_stock_data.dart';

abstract mixin class SearchStockDataProvider {
  late final searchData = Get.find<SearchStockData>();
}

class SearchStockData extends GetxController {
  StockService stockService = Get.find<StockService>();
  List<StockData> stocks = [];
  RxList<StockData> autoCompleteStocksList = <StockData>[].obs;
  List<StockIndustryInfo> stocksInfo = [];
  RxList<StockIndustryInfo> autoCompleteIndustryList =
      <StockIndustryInfo>[].obs;
  RxList<StockData> searchHistoryList = <StockData>[].obs;
  RxList<StockData> popularStockList = <StockData>[].obs;
  RxList<String> popularKeywordList = <String>[].obs;

  @override
  void onInit() {
    //searchHistoryList.addAll([]);
    loadLocalStockJson();
    super.onInit();
  }

  Future<void> loadLocalStockJson() async {
    final jsonList = stockService.krxStockDataList.value;
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
                  startsWith: true,
                  ignoreSpace: true,
                  ignoreCase: true,
                ),
              ).hasMatch(element.name))
          .toList();
    }
  }

  void addHistory(StockData stock) {
    searchHistoryList.remove(stock);
    searchHistoryList.add(stock);
    if (searchHistoryList.length > 20) {
      searchHistoryList.removeAt(0); // 리스트 크기가 20을 초과하면 가장 오래된 요소 제거
    }
  }

  void removeHistory(StockData stock) {
    searchHistoryList.remove(stock);
  }

  void removeAllHistory() {
    searchHistoryList.clear();
  }
}
