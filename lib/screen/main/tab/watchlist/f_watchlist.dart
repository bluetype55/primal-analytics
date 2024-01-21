import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/w_favorite_box.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/w_watchlist_box.dart';

class WatchlistFragment extends StatelessWidget {
  const WatchlistFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: context.themeType.themeData.scaffoldBackgroundColor,
            ),
          ),
          title: '관심목록'.text.make(),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              WatchlistBox(),
              FavoriteBox(),
            ],
          ),
        ),
      ],
    );
  }
}
