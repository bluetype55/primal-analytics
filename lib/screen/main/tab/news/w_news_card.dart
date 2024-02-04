import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/dart/extension/datetime_extension.dart';

import '../../../../data/news_api/vo_news_data.dart';

class NewsCard extends StatelessWidget {
  final NewsData news;

  NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: context.appColors.roundedLayoutBackgorund,
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            // 썸네일 이미지
            if (news.urlToImage != null)
              Expanded(
                child: Column(
                  children: [
                    Image.network(
                      news.urlToImage!,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            Width(15),
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 뉴스 제목
                      (news.title!.length > 65
                              ? '${news.title!.substring(0, 65)}...'
                              : news.title ?? 'No title')
                          .text
                          .bold
                          .size(14)
                          .make(),
                    ],
                  ),
                  emptyExpanded,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          height10,
                          // 저자 및 발행 날짜
                          '${news.author ?? 'Unknown Author'}'
                              .text
                              .size(12)
                              .color(context.appColors.lessImportant)
                              .overflow(TextOverflow.ellipsis)
                              .make(),

                          (DateTime.parse(news.publishedAt!)
                                      .formattedDateTime ??
                                  'Unknown Date')
                              .text
                              .size(12)
                              .color(context.appColors.lessImportant)
                              .overflow(TextOverflow.ellipsis)
                              .make(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).pOnly(left: 15, right: 15, top: 20, bottom: 15),
      ),
    );
  }
}
