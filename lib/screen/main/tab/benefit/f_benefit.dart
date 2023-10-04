import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:fast_app_base/screen/main/tab/benefit/dummy_benefit.dart';
import 'package:fast_app_base/screen/main/tab/benefit/w_benefit_item.dart';
import 'package:fast_app_base/screen/main/tab/benefit/w_point_button.dart';
import 'package:flutter/material.dart';

class BenefitFragment extends StatefulWidget {
  const BenefitFragment({super.key});

  @override
  State<BenefitFragment> createState() => _BenefitFragmentState();
}

class _BenefitFragmentState extends State<BenefitFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.themeType.themeData.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
            bottom: MainScreenState.bottomNavigatorHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height10,
            "혜택".text.bold.size(18).make(),
            height30,
            const PointButton(point: 569),
            height20,
            "혜택 더 받기".text.bold.size(16).make(),
            ...benefitList.map((e) => BenefitItem(benefit: e)).toList(),
          ],
        ).pSymmetric(h: 20),
      ),
    );
  }
}
