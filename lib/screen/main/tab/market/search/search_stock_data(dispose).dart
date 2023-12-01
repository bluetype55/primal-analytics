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
  RxList<String> searchHistoryList = <String>[].obs;

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

  // void search(String keyword) {
  //   if (keyword.isEmpty) {
  //     autoCompleteList.clear();
  //     return;
  //   }
  //   autoCompleteList.value = stocks.where((element) {
  //     return element.name.contains(keyword);
  //   }).toList();
  // }

  // void addHistory(SimpleStockDispose stock) {
  //   searchHistoryList.add(stock.name);
  // }
  void addHistory(String keyword) {
    searchHistoryList.add(keyword);
  }

  void removeHistory(String stockName) {
    searchHistoryList.remove(stockName);
  }

  void removeAllHistory() {
    searchHistoryList.clear();
  }
}
