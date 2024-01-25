import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/more/payment/payment_provider.dart';

class PaymentBox extends StatelessWidget with PaymentProvider {
  PaymentBox({
    super.key,
    required this.title,
    required this.price,
    required this.contents,
    this.isSelected = false,
  });
  final String title;
  final String price;
  final String contents;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 180,
      decoration: BoxDecoration(
        color: context.appColors.inActivate,
        border: Border.all(
            color: isSelected ? Colors.blue : context.appColors.lessImportant,
            width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title.text.bold.size(25).make(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              '$price / 월'.text.bold.size(20).make().pOnly(right: 20),
            ],
          ),
          height20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              contents.text.size(18).make().pOnly(bottom: 20),
            ],
          ),
        ],
      ),
    );
  }
}
