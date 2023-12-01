import 'package:get/get.dart';
import 'package:primal_analytics/data/stock_api/stock_api.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_data.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_industry_info.dart';

class StockService extends GetxService with StockApi {
  var krxStockDataList =
      Rxn<List<StockData>>(); // Rxn을 사용하여 nullable한 반응형 상태 관리
  var krxStockIndustryInfoList = Rxn<List<StockIndustryInfo>>();
  var krxStockData = Rxn<StockData>();
  var krxStockIndustryInfo = Rxn<StockIndustryInfo>();
  var isLoading = true.obs; // 로딩 상태 관리

  @override
  void onInit() {
    super.onInit();
    fetchKrxStockData();
  }

  void fetchKrxStockData([String? code]) async {
    try {
      isLoading(true);
      if (code == null) {
        krxStockDataList.value = await fetchStockData<StockData>(
            'krx', (json) => StockData.fromJson(json));
        krxStockIndustryInfoList.value =
            await fetchStockData<StockIndustryInfo>(
                'sector', (json) => StockIndustryInfo.fromJson(json));
      } else {
        final stockData = await fetchStockData<StockData>(
            'krx', (json) => StockData.fromJson(json), code);
        krxStockData.value = stockData[0];
        final stockInfo = await fetchStockData<StockIndustryInfo>(
            'sector', (json) => StockIndustryInfo.fromJson(json), code);
        krxStockIndustryInfo.value = stockInfo[0];
      }
    } catch (e) {
      print("Error fetching stock data: $e");
    } finally {
      isLoading(false);
    }
  }
}
