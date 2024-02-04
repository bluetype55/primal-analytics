import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

class NoDataBox extends StatelessWidget {
  const NoDataBox(
      {super.key,
      this.message = '데이터가 없습니다.',
      this.textSize = 10,
      this.iconSize = 30});
  final String message;
  final double textSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_outlined,
              size: iconSize,
            ),
            height20,
            message.text.size(textSize).make(),
          ],
        ),
      ],
    );
  }
}
