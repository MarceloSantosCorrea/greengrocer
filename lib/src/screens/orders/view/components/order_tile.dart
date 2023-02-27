import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/cart_item_model.dart';
import '../../../../models/order_model.dart';
import '../../../../services/utils_service.dart';
import '../../../widgets/payment_dialog.dart';
import '../../controller/order_controller.dart';
import 'order_status_widget.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final utilsService = UtilsService();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
          init: OrderController(),
          global: false,
          builder: (controller) {
            return ExpansionTile(
              // initiallyExpanded: order.status == 'pending_payment',
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pedido ${order.id}'),
                  Text(
                    utilsService.formatDateTime(order.createdDateTime!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 150,
                          child: ListView(
                            children: order.items.map((orderItem) {
                              return _OrderItemWidget(
                                utilsService: utilsService,
                                orderItem: orderItem,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2,
                        color: Colors.grey.shade300,
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: OrderStatusWidget(
                          status: order.status,
                          isOverdue:
                              order.overdueDateTime.isBefore(DateTime.now()),
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 20),
                    children: [
                      const TextSpan(
                        text: 'Total ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: utilsService.priceToCurrency(order.total),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: order.status == 'pending_payment',
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => PaymentDialog(
                          order: order,
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/app_images/pix.png',
                      height: 18,
                    ),
                    label: const Text('Ver QR Code Pix'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsService,
    required this.orderItem,
  }) : super(key: key);

  final UtilsService utilsService;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(orderItem.item.itemName),
          ),
          Text(
            utilsService.priceToCurrency(
              orderItem.totalPrice(),
            ),
          ),
        ],
      ),
    );
  }
}
