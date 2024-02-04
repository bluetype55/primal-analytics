import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/w_favorite_box.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/w_watchlist_box.dart';

class WatchlistFragment extends StatelessWidget {
  const WatchlistFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          'watchlist'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            height20,
            WatchlistBox(),
            height30,
            FavoriteBox(),
          ],
        ),
      ),
    );
  }
}
