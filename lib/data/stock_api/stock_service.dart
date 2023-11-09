import 'package:get/get.dart';
import 'package:primal_analytics/data/stock_api/stock_api.dart';
import 'package:primal_analytics/data/stock_api/stock_data.dart';

class StockService extends GetxService {
  var stockData = Rxn<List<StockData>>(); // Rxn을 사용하여 nullable한 반응형 상태 관리
  var isLoading = true.obs; // 로딩 상태 관리

  @override
  void onInit() {
    super.onInit();
    fetchStockData();
  }

  void fetchStockData() async {
    try {
      isLoading(true);
      var kospiRes = StockApi(market: "krx");
      stockData.value = await kospiRes.fetchStockData();
    } catch (e) {
      print("Error fetching stock data: $e");
    } finally {
      isLoading(false);
    }
  }
}
