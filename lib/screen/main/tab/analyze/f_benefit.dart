import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:fast_app_base/screen/main/tab/analyze/dummy_benefit.dart';
import 'package:fast_app_base/screen/main/tab/analyze/w_benefit_item.dart';
import 'package:fast_app_base/screen/main/tab/analyze/w_point_button.dart';
import 'package:flutter/material.dart';

class AnalyzeFragment extends StatefulWidget {
  const AnalyzeFragment({super.key});

  @override
  State<AnalyzeFragment> createState() => _AnalyzeFragmentState();
}

class _AnalyzeFragmentState extends State<AnalyzeFragment> {
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
