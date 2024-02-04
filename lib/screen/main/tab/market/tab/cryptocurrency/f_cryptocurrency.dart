import 'package:flutter/material.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/currencies/w_prepair_box.dart';

import '../../../../../../common/common.dart';
import '../../../../../../data/stock_api/finance_service.dart';

class CryptocurrencyFragment extends StatelessWidget
    with FinanceServiceProvider {
  CryptocurrencyFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Height(200),
        PrepareBox(),
        height20,
        botNavBarHeight,
      ],
    );
  }
}
