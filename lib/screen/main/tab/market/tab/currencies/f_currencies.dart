import 'package:flutter/material.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/currencies/w_prepair_box.dart';

import '../../../../../../common/common.dart';
import '../../../../../../data/stock_api/finance_service.dart';

class CurrenciesFragment extends StatelessWidget with FinanceServiceProvider {
  CurrenciesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Height(200),
        PrepareBox(),
        height20,
        botNavBarHeight,
      ],
    );
  }
}
