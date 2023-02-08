import 'package:flutter/material.dart';

import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  final Map<String, int> allStatus = {
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusDot(title: 'Pedido confirmado', isActive: true),
        _CustomDivider(),
        if (currentStatus == 1) ...[
          const _StatusDot(
            title: 'Pix estornado',
            isActive: true,
            backgroundColor: Colors.orange,
          ),
        ] else if (isOverdue) ...[
          const _StatusDot(
            title: 'Pagamento Pix vencido',
            isActive: true,
            backgroundColor: Colors.red,
          ),
        ] else ...[
          _StatusDot(
            title: 'Pagamento',
            isActive: currentStatus >= 2,
          ),
          _CustomDivider(),
          _StatusDot(
            title: 'Preparando',
            isActive: currentStatus >= 3,
          ),
          _CustomDivider(),
          _StatusDot(
            title: 'Envio',
            isActive: currentStatus >= 4,
          ),
          _CustomDivider(),
          _StatusDot(
            title: 'Entregue',
            isActive: currentStatus >= 5,
          ),
        ]
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backgroundColor;

  const _StatusDot({
    Key? key,
    required this.isActive,
    required this.title,
    this.backgroundColor,
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
            color: isActive
                ? backgroundColor ?? CustomColors.customSwatchColor
                : Colors.transparent,
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
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 3,
      ),
      color: Colors.grey.shade300,
    );
  }
}
