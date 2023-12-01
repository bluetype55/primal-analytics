import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/dart/extension/datetime_extension.dart';

class PopularSearchWordList extends StatelessWidget {
  const PopularSearchWordList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            '인기 검색어'.text.bold.make(),
            emptyExpanded,
            '오늘 ${DateTime.now().formattedTime} 기준'.text.size(12).make(),
          ],
        ),
        Divider(),
      ],
    ).pSymmetric(h: 20);
  }
}
