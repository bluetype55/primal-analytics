import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/stock_filter_provider.dart';

class StockFilter extends StatelessWidget with StockFilterProvider {
  StockFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5),
        scrollDirection: Axis.horizontal,
        itemCount: stockFilter.filterList.length,
        itemBuilder: (context, index) {
          final filter = stockFilter.filterList[index];
          return Obx(() => Tap(
                onTap: () => stockFilter.selectFilter(filter),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      filter.text.bold
                          .color(stockFilter.selectedFilter.value == filter
                              ? context.appColors.roundedLayoutBackgorund
                              : context.appColors.activate)
                          .make(),
                    ],
                  )
                      .box
                      .withRounded(value: 15)
                      .color(stockFilter.selectedFilter.value == filter
                          ? context.appColors.activate
                          : context.appColors.roundedLayoutBackgorund)
                      .border(color: context.appColors.text)
                      .p8
                      .make(),
                ),
              ));
        },
      ),
    );
  }
}
