import 'package:get/get.dart';
import 'package:primal_analytics/data/news_api/news_service.dart';
import 'package:primal_analytics/data/stock_api/stock_service.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';

import '../news_api/vo_news_data.dart';

abstract mixin class FinanceServiceProvider {
  final FinanceService finService = Get.find<FinanceService>();
}

class FinanceService extends GetxService with StockService, NewsService {
  var krxStockDataList =
      Rxn<List<StockData>>(); // Rxn을 사용하여 nullable한 반응형 상태 관리
  var krxStockIndustryInfoList = Rxn<List<StockIndustryInfo>>();
  var isAllStockDataLoading = true.obs; // 로딩 상태 관리
  var newsList = Rxn<List<NewsData>>();
  var isNewsLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllStockData();
    fetchNewsData();
  }

  // 데이터 로드 완료 여부를 확인하는 메서드
  Future<void> ensureDataLoaded() async {
    if (krxStockDataList.value == null) {
      await fetchAllStockData();
    }
  }

  Future<void> fetchAllStockData() async {
    try {
      isAllStockDataLoading(true);
      krxStockDataList.value = await fetchMarketData<StockData>('krx');
      krxStockIndustryInfoList.value =
          await fetchMarketData<StockIndustryInfo>('sector');
    } catch (e) {
      print("Error fetching stock data: $e");
    } finally {
      isAllStockDataLoading(false);
    }
  }

  Future<void> fetchNewsData() async {
    try {
      isNewsLoading(true);
      newsList.value = await fetchHeadlines<NewsData>();
    } catch (e) {
      print("Error fetching news data: $e");
    } finally {
      isNewsLoading(false);
    }
  }

  T? findingDataWithCode<T>(String code) {
    switch (T) {
      case StockData:
        return krxStockDataList.value
            ?.firstWhereOrNull((stock) => stock.code == code) as T?;
      case StockIndustryInfo:
        return krxStockIndustryInfoList.value
            ?.firstWhereOrNull((stock) => stock.code == code) as T?;
      default:
        throw Exception("Please check StockApi method");
    }
  }
}
