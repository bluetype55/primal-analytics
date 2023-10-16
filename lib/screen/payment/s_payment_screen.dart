import 'package:flutter/material.dart';

import '../../common/common.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Nav.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ],
    );
  }
}
