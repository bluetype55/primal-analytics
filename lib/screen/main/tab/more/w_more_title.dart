import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

class MoreTitle extends StatelessWidget {
  const MoreTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          '토스증권'.text.size(24).bold.make(),
          width20,
          'S&P500'
              .text
              .size(13)
              .bold
              .color(context.appColors.lessImportant)
              .make(),
          width10,
          3919.29
              .toComma()
              .toString()
              .text
              .size(13)
              .bold
              .color(context.appColors.plus)
              .make(),
        ],
      ).pOnly(left: 20),
    );
  }
}
