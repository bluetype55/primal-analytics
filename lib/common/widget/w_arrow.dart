import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

class Arrow extends StatelessWidget {
  final double size;
  final AxisDirection direction;
  final Color? color;

  const Arrow({Key? key, this.size = 15, this.color, AxisDirection? direction})
      : direction = direction ?? AxisDirection.right,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? context.appColors.text,
    );
  }

  IconData get icon {
    switch (direction) {
      case AxisDirection.up:
        return Icons.keyboard_arrow_up;
      case AxisDirection.right:
        return Icons.arrow_forward_ios;
      case AxisDirection.down:
        return Icons.keyboard_arrow_down;
      case AxisDirection.left:
        return Icons.arrow_back_ios;
    }
  }
}
