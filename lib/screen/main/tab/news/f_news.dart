import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/widget/w_no_data_box.dart';
import 'package:primal_analytics/data/stock_api/finance_service.dart';
import 'package:primal_analytics/screen/main/tab/news/w_news_card.dart';

import '../../../../common/common.dart';

class NewsFragment extends StatefulWidget {
  const NewsFragment({super.key});

  @override
  State<NewsFragment> createState() => _NewsFragmentState();
}

class _NewsFragmentState extends State<NewsFragment>
    with FinanceServiceProvider {
  @override
  Widget build(BuildContext context) {
    print('뉴스리스트: ${finService.newsList.value}');
    if (finService.newsList.value != null) {
      print('뉴스리스트: ${finService.newsList.value!.length}');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          'news'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                finService.isNewsLoading.value
                    ? const CircularProgressIndicator()
                    : finService.newsList.value != null &&
                            finService.newsList.value != []
                        ? NewsCard(news: finService.newsList.value![5])
                        : const NoDataBox(),
              ],
            ),
            botNavBarHeight,
          ],
        ),
      ),
    );
  }
}
