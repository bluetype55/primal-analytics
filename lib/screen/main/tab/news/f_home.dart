import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/widget/w_big_button.dart';
import 'package:primal_analytics/common/widget/w_rounded_container.dart';
import 'package:primal_analytics/data/stock_api/firestore_service.dart';
import 'package:primal_analytics/screen/dialog/d_message.dart';
import 'package:primal_analytics/screen/main/s_main.dart';
import 'package:primal_analytics/screen/main/tab/news/dummy_bank_accounts.dart';
import 'package:primal_analytics/screen/main/tab/news/w_bank_account.dart';
import 'package:primal_analytics/screen/main/tab/news/w_ttoss_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../data/stock_api/web_crawlring.dart';
import '../../../dialog/d_color_bottom.dart';
import '../../../dialog/d_confirm.dart';

class NewsFragment extends StatelessWidget {
  const NewsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    WebCrawler crawler = WebCrawler();
    FirestoreService fstoreService = FirestoreService();

    return Container(
      child: Stack(
        children: [
          RefreshIndicator(
            edgeOffset: TtossAppBar.appBarHeight,
            onRefresh: () async {
              await sleepAsync(500.ms);
              // List<List<dynamic>> rows = await crawler.fetchDataAndSaveToFile();
              // await crawler.saveToFirestore(rows);
              String? stockName =
                  await fstoreService.fetchItemNameByCode("067080");
              String? stockCode = await fstoreService.fetchCodeByItemName("한싹");
              print('주식이름 : $stockName');
              print('주식코드 : $stockCode');
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                  top: TtossAppBar.appBarHeight,
                  bottom: MainScreenState.bottomNavigatorHeight),
              child: Column(
                children: [
                  BigButton(
                    "토스뱅크",
                    onTap: () {
                      context.showSnackbar('토스뱅크를 눌렀어요');
                    },
                  ),
                  height10,
                  RoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '자산'.text.bold.make(),
                        height5,
                        ...bankAccounts
                            .map((e) => BankAccountWidget(e))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ).pSymmetric(h: 20),
            ).animate().slide(duration: 1000.ms).fadeIn(),
          ),
          const TtossAppBar(),
        ],
      ),
    );
  }

  void showSnackbar(BuildContext context) {
    context.showSnackbar('snackbar 입니다.',
        extraButton: Tap(
          onTap: () {
            context.showErrorSnackbar('error');
          },
          child: '에러 보여주기 버튼'
              .text
              .white
              .size(13)
              .make()
              .centered()
              .pSymmetric(h: 10, v: 5),
        ));
  }

  Future<void> showConfirmDialog(BuildContext context) async {
    final confirmDialogResult = await ConfirmDialog(
      '오늘 기분이 좋나요?',
      buttonText: "네",
      cancelButtonText: "아니오",
    ).show();
    debugPrint(confirmDialogResult?.isSuccess.toString());

    confirmDialogResult?.runIfSuccess((data) {
      ColorBottomSheet(
        '❤️',
        context: context,
        backgroundColor: Colors.yellow.shade200,
      ).show();
    });

    confirmDialogResult?.runIfFailure((data) {
      ColorBottomSheet(
        '❤️힘내여',
        backgroundColor: Colors.yellow.shade300,
        textColor: Colors.redAccent,
      ).show();
    });
  }

  Future<void> showMessageDialog() async {
    final result = await MessageDialog("안녕하세요").show();
    debugPrint(result.toString());
  }

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
