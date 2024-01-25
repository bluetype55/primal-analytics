import 'package:flutter/material.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/currencies/w_prepair_box.dart';

import '../../../../../../data/stock_api/finance_service.dart';

class CurrenciesFragment extends StatelessWidget with FinanceServiceProvider {
  CurrenciesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 200),
      child: PrepareBox(),
    );
  }
}
