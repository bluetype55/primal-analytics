import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/widget/w_round_button.dart';
import 'package:primal_analytics/common/widget/w_rounded_container.dart';

class NumberDialog extends DialogWidget<int?> {
  NumberDialog({super.key, super.animation = NavAni.Fade});

  @override
  DialogState<NumberDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends DialogState<NumberDialog> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedContainer(
            child: Column(
              children: [
                '숫자를 입력해주세요'.text.make(),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                ),
                RoundButton(
                    text: '완료',
                    onTap: () {
                      final text = controller.text;
                      int number = int.parse(text);
                      widget.hide(number);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
