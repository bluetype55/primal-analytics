import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/widget/w_rounded_container.dart';

class SubscriptionBox extends StatelessWidget {
  const SubscriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(child: 'data'.text.make());
  }
}
