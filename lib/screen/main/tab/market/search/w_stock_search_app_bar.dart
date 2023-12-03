import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/util/app_keyboard_util.dart';
import 'package:primal_analytics/common/widget/w_arrow.dart';
import 'package:primal_analytics/common/widget/w_text_field_with_delete.dart';

class StockSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  const StockSearchAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          children: [
            Tap(
                onTap: () {
                  if (controller.text == '') {
                    Nav.pop(context);
                  } else {
                    controller.clear();
                  }
                },
                child: const SizedBox(
                  width: 56,
                  height: kToolbarHeight,
                  child: Arrow(
                    direction: AxisDirection.left,
                  ),
                )),
            Expanded(
                child: TextFieldWithDelete(
              controller: controller,
              autofocus: true,
              texthint: "원하시는 종목을 검색해보세요.",
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                AppKeyboardUtil.hide(context);
              },
            ).pOnly(top: 6)),
            width20,
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
        double.infinity,
        kToolbarHeight,
      );
}
