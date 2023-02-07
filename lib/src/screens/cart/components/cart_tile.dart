import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/screens/widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../../../models/cart_item_model.dart';

class CartTile extends StatelessWidget {
  final CartItemModel cartItem;
  final UtilsService utilsService = UtilsService();
  CartTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: Image.asset(
          cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          utilsService.priceToCurrency(cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: QuantityWidget(
          value: cartItem.quantity,
          sufixText: cartItem.item.unit,
          result: (quantity) {},
        ),
      ),
    );
  }
}
