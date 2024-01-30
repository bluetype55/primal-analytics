import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

class TeamInfoSection extends StatelessWidget {
  const TeamInfoSection(
      {super.key,
      required this.icon,
      required this.title,
      required this.contents});

  final Icon icon;
  final String title;
  final String contents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon.pSymmetric(h: 10),
            title.text.bold.size(20).make(),
          ],
        ),
        height10,
        contents.text.make().pOnly(left: 25),
      ],
    ).pSymmetric(v: 10);
  }
}
