import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/notification/vo/vo_notification.dart';
import 'package:primal_analytics/screen/notification/w_notification_item.dart';

class NotificationDialog extends DialogWidget {
  final List<TtossNotification> notifications;

  NotificationDialog(this.notifications,
      {super.key, super.animation = NavAni.Bottom});

  @override
  DialogState<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends DialogState<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...widget.notifications
              .map(
                (element) => NotifcationItemWidget(
                    notification: element,
                    onTap: () {
                      widget.hide();
                    }),
              )
              .toList()
        ],
      ),
    );
  }
}
