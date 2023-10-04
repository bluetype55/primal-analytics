import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotifcationItemWidget extends StatefulWidget {
  final TtossNotification notification;
  final VoidCallback onTap;

  const NotifcationItemWidget(
      {super.key, required this.notification, required this.onTap});

  @override
  State<NotifcationItemWidget> createState() => _NotifcationItemWidgetState();
}

class _NotifcationItemWidgetState extends State<NotifcationItemWidget> {
  static const leftPadding = 10.0;
  static const iconWidth = 25.0;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: widget.notification.isRead
            ? context.backgroundColor
            : context.appColors.unReadColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Width(leftPadding),
                Image.asset(
                  widget.notification.type.iconPath,
                  width: iconWidth,
                ),
                widget.notification.type.name.text
                    .size(12)
                    .color(context.appColors.lessImportant)
                    .make(),
                emptyExpanded,
                timeago
                    .format(widget.notification.time,
                        locale: context.locale.languageCode)
                    .text
                    .size(13)
                    .color(context.appColors.lessImportant)
                    .make(),
                width10,
              ],
            ),
            widget.notification.description.text
                .make()
                .pOnly(left: leftPadding + iconWidth),
          ],
        ),
      ),
    );
  }
}
