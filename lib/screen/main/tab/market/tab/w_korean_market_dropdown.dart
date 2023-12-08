import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/dropdown_provider.dart';

class KoreanMarketDropdownButton extends StatelessWidget with DropdownProvider {
  KoreanMarketDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton(
          value: dropdownController.koreanMarketselectedValue.value,
          items: dropdownController.koreanMarketDropdownMenuList
              .map((String value) {
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
