import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

class ScreenDoor extends StatelessWidget {
  const ScreenDoor({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tap(
        onTap: () {
          context.showErrorSnackbar('내가 찜한 종목만 AI 예측가를 확인할 수 있습니다.');
        },
        child: Container(
          height: 100,
          width: 380,
          decoration: BoxDecoration(
            color: context.appColors.roundedLayoutBackgorund,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: context.appColors.unReadColor.withOpacity(0.5), // 그림자 색상
                spreadRadius: 2, // 그림자의 범위 퍼짐 정도
                blurRadius: 4, // 그림자의 흐림 정도
                offset: Offset(0, 3), // 그림자의 위치 변경 (수평, 수직)
              ),
            ],
          ),
          child: Icon(
            Icons.lock_outline,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
