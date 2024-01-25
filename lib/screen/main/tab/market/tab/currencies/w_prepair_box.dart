import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

class PrepareBox extends StatelessWidget {
  const PrepareBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: context.appColors.roundedLayoutBackgorund,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '서비스 준비중입니다',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: context.appColors.lessImportant),
        ),
      ),
    );
  }
}
