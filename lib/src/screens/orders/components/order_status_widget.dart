import 'package:flutter/material.dart';

import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  const OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _StatusDot(title: 'Pedido confirmado', isActive: true),
        _StatusDot(title: '', isActive: false),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;

  const _StatusDot({
    Key? key,
    required this.isActive,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColors.customSwatchColor),
            color:
                isActive ? CustomColors.customSwatchColor : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 5),
        Expanded(child: Text(title)),
      ],
    );
  }
}
