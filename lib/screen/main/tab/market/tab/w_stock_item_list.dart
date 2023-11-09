import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_stock_item.dart';

import '../../../../../data/stock_api/stock_data.dart';
import 'dropdown_controller.dart';
import 'dropdown_menu_list.dart';

class StockItemList extends StatelessWidget {
  StockItemList(this.stocks,
      {super.key, this.limit, this.sortby, this.ascending = false});

  final List<StockData> stocks;
  final int? limit;
  final String? sortby;
  final bool ascending;

  int compareFunc<T extends Comparable>(T a, T b, bool ascending) {
    if (ascending) {
      return a.compareTo(b);
    } else {
      return b.compareTo(a);
    }
  }

  void sortStock(String? fieldName, bool ascending) {
    stocks.sort((a, b) {
      switch (fieldName) {
        case 'changesRatio':
          return compareFunc<double>(a.changesRatio, b.changesRatio, ascending);
        case 'marcap':
          return compareFunc<int>(a.marcap, b.marcap, ascending);
        case 'high':
          return compareFunc<int>(a.high, b.high, ascending);
        default:
          return compareFunc<int>(a.amount, b.amount, ascending); // 기본값이나 오류 처리
      }
    });
  }

  final DropdownController dropdownController = Get.find<DropdownController>();

  @override
  Widget build(BuildContext context) {
    sortStock(sortby, ascending);

    return limit == null
        ? Obx(() => dropdownController.koreanMarketselectedValue.value ==
                koreanMarketDropdownMenuList[0]
            ? SizedBox(
                height: MediaQuery.of(context).size.height -
                    kBottomNavigationBarHeight * 1.5,
                child: ListView.builder(
                    itemCount: stocks.length,
                    itemBuilder: (context, index) => StockItem(stocks[index])),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height -
                    kBottomNavigationBarHeight * 1.5,
                child: ListView.builder(
                    itemCount: stocks.length,
                    itemBuilder: (context, index) => stocks[index].market ==
                            dropdownController.koreanMarketselectedValue.value
                        ? StockItem(stocks[index])
                        : Container()),
              ))
        : Obx(() => dropdownController.koreanMarketselectedValue.value ==
                koreanMarketDropdownMenuList[0]
            ? Column(
                children: [
                  ...stocks
                      .take(limit!)
                      .map((element) => StockItem(element))
                      .toList(),
                ],
              )
            : Column(
                children: [
                  ...stocks
                      .where((element) =>
                          element.market ==
                          dropdownController.koreanMarketselectedValue.value)
                      .take(limit!)
                      .map((element) => StockItem(element))
                      .toList(),
                ],
              ));
  }
}
