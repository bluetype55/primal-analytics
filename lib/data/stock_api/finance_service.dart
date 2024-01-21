import 'package:get/get.dart';
import 'package:primal_analytics/data/stock_api/stock_service.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';

abstract mixin class FinanceServiceProvider {
  final FinanceService finService = Get.find<FinanceService>();
}

class FinanceService extends GetxService with StockService {
  var krxStockDataList =
      Rxn<List<StockData>>(); // Rxn을 사용하여 nullable한 반응형 상태 관리
  var krxStockIndustryInfoList = Rxn<List<StockIndustryInfo>>();
  var isKrxStockLoading = true.obs; // 로딩 상태 관리

  @override
  void onInit() {
    super.onInit();
    fetchAllKrxData();
  }

  // 데이터 로드 완료 여부를 확인하는 메서드
  Future<void> ensureDataLoaded() async {
    if (krxStockDataList.value == null) {
      await fetchAllKrxData();
    }
  }

  Future<void> fetchAllKrxData() async {
    try {
      isKrxStockLoading(true);
      krxStockDataList.value = await fetchMarketData<StockData>('krx');
      krxStockIndustryInfoList.value =
          await fetchMarketData<StockIndustryInfo>('sector');
    } catch (e) {
      print("Error fetching stock data: $e");
    } finally {
      isKrxStockLoading(false);
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
