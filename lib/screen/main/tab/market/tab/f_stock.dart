import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/widget/w_arrow.dart';
import 'package:primal_analytics/common/widget/w_rounded_container.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_interest_stock_list.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/w_stock_sorting_box.dart';

import '../../../../../common/widget/w_long_button.dart';

class StockFragment extends StatelessWidget {
  const StockFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockSortingBox('국내'),
        height20,
        getMyStock(context),
        botNavBarHeight,
      ],
    );
  }

  Widget getmyAccount(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: context.appColors.roundedLayoutBackgorund,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height20,
            '계좌'.text.make(),
            Row(
              children: [
                width20,
                '443원'.text.size(24).bold.make(),
                const Arrow(),
                emptyExpanded,
                RoundedContainer(
                  radius: 8,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  backgroundColor: context.appColors.buttonBackground,
                  child: '채우기'.text.size(12).bold.make(),
                ),
                width20,
              ],
            ),
            height30,
            Line(
              color: context.appColors.divider,
            ),
            height10,
            const LongButton(
              title: '주문내역',
            ),
            const LongButton(
              title: '판매내역',
            ),
          ],
        ),
      );
  Widget getMyStock(BuildContext context) => Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: context.appColors.roundedLayoutBackgorund,
            child: Column(
              children: [
                height30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    '관심주식'.text.bold.make(),
                    '편집하기'
                        .text
                        .color(context.appColors.lessImportant)
                        .bold
                        .make(),
                  ],
                ),
                height20,
                Tap(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        '기본'.text.make(),
                        const Arrow(
                          direction: AxisDirection.up,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          InterestStockList().pSymmetric(h: 20),
        ],
      );
}