import 'package:flutter/material.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_daily.dart';

import '../../../../../../data/stock_api/stock_service.dart';

class CurrenciesFragment extends StatelessWidget with StockServiceProvider {
  CurrenciesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<StockDaily>>(
          future: stockService.codeToData<StockDaily>('005930'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // 로딩 중일 때 보여줄 위젯
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error.toString()}');
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var stockDaily = snapshot.data!; // null 체크 후 사용
              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    kBottomNavigationBarHeight * 3,
                child: ListView.builder(
                  itemCount: stockDaily.length,
                  itemBuilder: (context, index) {
                    var stock = stockDaily[index];
                    return ListTile(
                      title: Text("${index + 1}. ${stock.date}"),
                    );
                  },
                ),
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ],
    );
  }
}
