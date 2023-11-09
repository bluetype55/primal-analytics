import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_stock_item_list.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_stock_sorting_box.dart';

import 'dropdown_controller.dart';

class StockListScreen extends StatelessWidget {
  final String title;
  final StockItemList stockItemList;
  StockListScreen({
    required this.title,
    super.key,
    required this.stockItemList,
  });

  final DropdownController dropdownController = Get.find<DropdownController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.themeType.themeData.scaffoldBackgroundColor,
        title: title.text.bold.make(),
        actions: [
          KoreanMarketDropdownButton(dropdownController: dropdownController),
          width20,
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stockItemList,
          ],
        ),
      ),
    );
  }
}
