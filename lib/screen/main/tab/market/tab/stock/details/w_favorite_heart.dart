import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/favorite_provider.dart';

class FavoriteHeartWidget extends StatelessWidget with FavoriteProvider {
  FavoriteHeartWidget(
    this.code, {
    super.key,
  });
  final String code;

  @override
  Widget build(BuildContext context) {
    // 즐겨찾기 상태 확인
    favoriteController.checkFavoriteStatus(code);
    return Obx(() => Tap(
          onTap: () {
            favoriteController.toggleFavorite(code, context);
          },
          child: favoriteController.isFavorite.value
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ).pOnly(right: 20)
              : const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                ).pOnly(right: 20),
        ));
  }
}
