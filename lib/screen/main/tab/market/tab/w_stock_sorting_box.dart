import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/widget/w_arrow.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/dropdown_menu_list.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/s_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_stock_item_list.dart';

import '../../../../../data/stock_api/stock_service.dart';
import 'dropdown_controller.dart';

class StockSortingBox extends StatelessWidget {
  StockSortingBox(
    this.title, {
    super.key,
  });
  final StockService stockService = Get.find<StockService>();
  final DropdownController dropdownController = Get.find<DropdownController>();
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.roundedLayoutBackgorund,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Row(
                  children: [
                    title.text.size(20).bold.make(),
                    emptyExpanded,
                    KoreanMarketDropdownButton(
                        dropdownController: dropdownController),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Obx(() => stockService.stockData.value != null
                            ? Column(
                                children: [
                                  StockItemList(stockService.stockData.value!,
                                      limit: 5),
                                  height10,
                                  Tap(
                                    onTap: () {
                                      Nav.push(StockListScreen(
                                          title: title,
                                          stockItemList: StockItemList(
                                              stockService.stockData.value!)));
                                    },
                                    child: const Row(
                                      children: [
                                        EmptyExpanded(),
                                        Text('더보기'),
                                        Arrow(
                                          direction: AxisDirection.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ) // 데이터가 있으면 표시
                            : const Text('no data') // 데이터가 없으면 "no data" 표시
                        ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KoreanMarketDropdownButton extends StatelessWidget {
  const KoreanMarketDropdownButton({
    super.key,
    required this.dropdownController,
  });

  final DropdownController dropdownController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton(
          value: dropdownController.koreanMarketselectedValue.value,
          items: koreanMarketDropdownMenuList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: value.text.make(),
            );
          }).toList(),
          onChanged: (String? newValue) {
            dropdownController.koreanMarketchangeSelectedValue(newValue!);
          }),
    );
  }
}
