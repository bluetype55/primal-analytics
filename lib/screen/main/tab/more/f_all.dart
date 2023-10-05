import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

class MoreFragment extends StatefulWidget {
  const MoreFragment({super.key});

  @override
  State<MoreFragment> createState() => _MoreFragmentState();
}

class _MoreFragmentState extends State<MoreFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: context.themeType.themeData.scaffoldBackgroundColor,
              ),
            ),
            title: '전체'.text.make(),
          ),
          SliverToBoxAdapter(
            child: title,
          ),
        ],
      ),
    );
  }

  Widget get title => Container(
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
