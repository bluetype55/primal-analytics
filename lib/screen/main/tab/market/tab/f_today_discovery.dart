import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:primal_analytics/common/common.dart';

import '../../../../../data/stock_api/stock_api.dart';
import '../../../../../data/stock_api/stock_service.dart';

class TodayDiscoveryFragment extends StatefulWidget {
  const TodayDiscoveryFragment({super.key});

  @override
  State<TodayDiscoveryFragment> createState() => _TodayDiscoveryFragmentState();
}

class _TodayDiscoveryFragmentState extends State<TodayDiscoveryFragment> {
  Future fetchData() async {
    var kospiRes = StockApi(market: "kospi");
    return await kospiRes.fetchStockData();
  }

  final StockService stockService = Get.find<StockService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // 로딩 중일 때 보여줄 위젯
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              print('Error: ${snapshot.connectionState}');
              return Text('Error: ${snapshot.error}'); // 에러 발생 시 보여줄 위젯
            } else {
              // 데이터가 로드되었을 때 수행될 코드
              var stockData = snapshot.data;
              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    kBottomNavigationBarHeight * 3,
                child: ListView.builder(
                  itemCount: stockData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${index + 1}. ${stockData[index].name}"),
                      subtitle: Text(
                          "${stockData[index].code} : ${stockData[index].changes}"),
                    );
                  },
                ),
              ); // 데이터를 표시하는 데 사용할 위젯
            }
          },
        ),
      ],
    );
  }
}
