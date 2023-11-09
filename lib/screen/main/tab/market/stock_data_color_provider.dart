import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

abstract mixin class StockDataColorProvider {
  int get changes;
  double get changesRatio;

  String get changesString =>
      "${changes.abs()}원 ($symbol${changesRatio.abs()}%)";

  bool get isPlus => changes > 0;
  bool get isZero => changes == 0;
  bool get isMinus => changes < 0;

  String get symbol => isZero
      ? ""
      : isPlus
          ? "+"
          : "-";

  Widget icon(BuildContext context) => isZero
      ? Container()
      : isPlus
          ? Icon(
              Icons.arrow_drop_up,
              color: context.appColors.plus,
            )
          : Icon(
              Icons.arrow_drop_down,
              color: context.appColors.minus,
            );

  Color getPriceColor(BuildContext context) => isZero
      ? context.appColors.lessImportant
      : isPlus
          ? context.appColors.plus
          : context.appColors.minus;
}
