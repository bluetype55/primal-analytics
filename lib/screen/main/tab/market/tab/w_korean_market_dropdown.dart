import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/common.dart';

import 'dropdown_controller.dart';
import 'dropdown_menu_list.dart';

class KoreanMarketDropdownButton extends StatelessWidget {
  const KoreanMarketDropdownButton({
    super.key,
    required this.dropdownController,
  });

  final DropdownController dropdownController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton(
          value: dropdownController.koreanMarketselectedValue.value,
          items: koreanMarketDropdownMenuList.map((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: value == 'all'
                    ? value.tr().text.make()
                    : value.text.make());
          }).toList(),
          onChanged: (String? newValue) {
            dropdownController.koreanMarketchangeSelectedValue(newValue);
          }),
    );
  }
}
