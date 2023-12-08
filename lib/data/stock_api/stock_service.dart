import 'package:get/get.dart';
import 'package:primal_analytics/data/stock_api/stock_api.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';

abstract mixin class StockServiceProvider {
  final StockService stockService = Get.find<StockService>();
}

class StockService extends GetxService with StockApi {
  var krxStockDataList =
      Rxn<List<StockData>>(); // Rxn을 사용하여 nullable한 반응형 상태 관리
  var krxStockIndustryInfoList = Rxn<List<StockIndustryInfo>>();
  var isKrxStockLoading = true.obs; // 로딩 상태 관리

  @override
  void onInit() {
    super.onInit();
    fetchAllKrxData();
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
