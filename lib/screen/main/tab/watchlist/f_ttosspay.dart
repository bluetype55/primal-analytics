import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

import '../../../../data/stock_api/web_crawlring.dart';

class WatchlistFragment extends StatefulWidget {
  const WatchlistFragment({super.key});

  @override
  State<WatchlistFragment> createState() => _WatchlistFragmentState();
}

class _WatchlistFragmentState extends State<WatchlistFragment> {
  void showData() async {
    WebCrawler webCrawler = WebCrawler();
    List<List<dynamic>> data = await webCrawler.fetchDataAndSaveToFile();
    print(data);
  }

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
        const SliverToBoxAdapter(
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }
}
