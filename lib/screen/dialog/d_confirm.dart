import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:primal_analytics/common/widget/scaffold/center_dialog_scaffold.dart';
import 'package:primal_analytics/data/simple_result.dart';

import '../../common/common.dart';

class ConfirmDialog extends DialogWidget<SimpleResult> {
  final String? message;
  final String confirmButtonText;
  final String cancelButtonText;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final bool cancelable;
  final TextAlign textAlign;
  final double messageFontSize;
  final double buttonFontSize;
  final Function? function;
  final Function? cancelFunction;

  ConfirmDialog({
    super.context,
    super.key,
    String? confirmButtonText,
    String? cancelButtonText,
    this.message,
    this.messageFontSize = 18,
    this.buttonFontSize = 16,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.cancelable = true,
    this.textAlign = TextAlign.center,
    this.function,
    this.cancelFunction,
  })  : confirmButtonText = confirmButtonText ?? 'confirm'.tr(),
        cancelButtonText = cancelButtonText ?? 'cancel'.tr();

  @override
  State<StatefulWidget> createState() {
    return _MessageDialogState();
  }
}

class _MessageDialogState extends DialogState<ConfirmDialog> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CenterDialogScaffold(
        body: Container(
            constraints: BoxConstraints(maxHeight: context.deviceHeight),
            decoration: BoxDecoration(
                color: context.appColors.drawerBg,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Text(
                          widget.message ?? 'confirm_message'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: widget.messageFontSize,
                              color: context.appColors.text),
                          textAlign: widget.textAlign,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    )
                  ],
                ),
                Line(color: context.appColors.divider),
                Row(
                  children: [
                    Expanded(
                      child: Tap(
                        onTap: () {
                          if (widget.cancelFunction != null) {
                            widget.cancelFunction!();
                          }
                          widget.hide(SimpleResult.failure());
                        },
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              widget.cancelButtonText,
                              style: TextStyle(
                                color: widget.cancelButtonColor ??
                                    context.appColors.lessImportant,
                                fontSize: widget.buttonFontSize,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Tap(
                        onTap: () {
                          if (widget.function != null) {
                            widget.function!();
                          }
                          widget.hide(SimpleResult.success());
                        },
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              widget.confirmButtonText,
                              style: TextStyle(
                                color: widget.confirmButtonColor ??
                                    context.appColors.confirmText,
                                fontSize: widget.buttonFontSize,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
