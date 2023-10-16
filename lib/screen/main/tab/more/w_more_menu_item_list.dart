import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/market/setting/s_setting_screen.dart';
import 'package:flutter/material.dart';

import '../../../opensource/s_opensource.dart';
import '../../../payment/s_payment_screen.dart';
import '../../w_menu_drawer.dart';

class MoreMenuItemList extends StatelessWidget {
  const MoreMenuItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Line(),
        MenuItemWidget(
          'opensource'.tr(),
          onTap: () async {
            Nav.push(const OpensourceScreen());
          },
        ),
        const Line(),
        MenuItemWidget(
          '결제',
          onTap: () async {
            Nav.push(const PaymentScreen());
          },
        ),
        const Line(),
        MenuItemWidget(
          'setting'.tr(),
          onTap: () async {
            Nav.push(const SettingScreen());
          },
        ),
        const Line(),
      ],
    );
  }
}
