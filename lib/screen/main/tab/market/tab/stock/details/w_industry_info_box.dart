import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/data/stock_api/finance_service.dart';
import 'package:primal_analytics/data/stock_api/vo_stock_finance.dart';

import '../../../../../../../data/stock_api/vo_stock_data.dart';
import '../../../../../../../data/stock_api/vo_stock_industry_info.dart';

class IdstBox extends StatelessWidget with FinanceServiceProvider {
  IdstBox(this.code, {super.key});
  final String code;

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      children: [
        TableCell(
            child: Center(
                child: Text(
          label,
          overflow: TextOverflow.ellipsis,
        )).pSymmetric(v: 10)),
        TableCell(
          child: value.text
              .overflow(TextOverflow.clip)
              .make()
              .pSymmetric(v: 10)
              .marginOnly(right: 60),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final idstInfo = finService.findingDataWithCode<StockIndustryInfo>(code);
    final stock = finService.findingDataWithCode<StockData>(code);
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        finService.codeToData<StockIndustryInfo>(code),
        finService.codeToData<StockFinance>(code),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error.toString()}');
        } else if (snapshot.hasData) {
          StockIndustryInfo stockIdst =
              StockIndustryInfo("-", "-", "-", "-", "-", "-", "-", "-", "-");
          StockFinance stockfin =
              StockFinance("-", "-", "-", "-", "-", "-", "-", 0, 0);
          if (snapshot.data![0].isNotEmpty) stockIdst = snapshot.data![0][0];
          if (snapshot.data![1].isNotEmpty) stockfin = snapshot.data![1][0];
          return Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(130),
              1: FixedColumnWidth(270),
            },
            children: [
              _buildTableRow('업종', stockIdst.industry),
              _buildTableRow('주요제품', stockIdst.mainProduct),
              _buildTableRow('상장일', stockIdst.listingDate),
              _buildTableRow('대표자명', stockIdst.ceo),
              _buildTableRow('홈페이지', stockIdst.webSite),
              _buildTableRow(
                  '시가총액(억)', (stock!.marcap / 100000000).round().toComma()),
              _buildTableRow(
                  '거래대금(만)', (stock.amount / 10000).round().toComma()),
              _buildTableRow('PER', stockfin.per),
              _buildTableRow('선행 PER', stockfin.fwdPer),
              _buildTableRow(
                  'EPS', int.tryParse(stockfin.eps)?.toComma() ?? stockfin.eps),
              _buildTableRow('선행 EPS',
                  int.tryParse(stockfin.fwdEps)?.toComma() ?? stockfin.fwdEps),
              _buildTableRow('PBR', stockfin.pbr),
              _buildTableRow(
                  'BPS', int.tryParse(stockfin.bps)?.toComma() ?? stockfin.bps),
              _buildTableRow('배당수익률', '${stockfin.dividendYield}'),
              _buildTableRow('주당배당금(원)', stockfin.dps.toComma()),
            ],
          ).pSymmetric(h: 20);
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_outlined,
                size: 50,
              ),
              height20,
              '데이터가 없습니다.'.text.size(15).make(),
            ],
          );
        }
      },
    );
  }
}
