import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:primal_analytics/screen/main/tab/more/payment/payment_provider.dart';
import 'package:primal_analytics/screen/main/tab/more/payment/w_payment_box.dart';

import '../../../../../common/common.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with PaymentProvider {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentController.selectedBoxIndex.value =
        paymentController.currentSubscriptIndex.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Nav.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ).pSymmetric(v: 20, h: 10),
              ],
            ),
            Tap(
              onTap: () => paymentController.selectBox(0),
              child: Obx(
                () => PaymentBox(
                  title: 'Basic',
                  price: '무료',
                  contents: ' 월간 5개 종목에 대한\nAI를 통한 예측 값 제공',
                  isSelected: paymentController.selectedBoxIndex.value == 0,
                ),
              ),
            ),
            height20,
            Tap(
              onTap: () => paymentController.selectBox(1),
              child: Obx(
                () => PaymentBox(
                  title: 'Standard',
                  price: '1,000',
                  contents: ' 월간 15개 종목에 대한\nAI를 통한 예측 값 제공',
                  isSelected: paymentController.selectedBoxIndex.value == 1,
                ),
              ),
            ),
            height20,
            Tap(
              onTap: () => paymentController.selectBox(2),
              child: Obx(
                () => PaymentBox(
                  title: 'Pro',
                  price: '2,000',
                  contents: ' 월간 30개 종목에 대한\nAI를 통한 예측 값 제공',
                  isSelected: paymentController.selectedBoxIndex.value == 2,
                ),
              ),
            ),
            height20,
            ElevatedButton(
              onPressed: () {
                switch (paymentController.selectedBoxIndex.value) {
                  case 0:
                    paymentController.handleBasicPlan(context);
                    break;
                  case 1:
                    paymentController.handleStandardPlan(context);
                    break;
                  case 2:
                    paymentController.handleProPlan(context);
                    break;
                  default:
                    break;
                }
              },
              child: Text('요금제 변경'),
            ),
          ],
        ),
      ),
    );
  }
}
