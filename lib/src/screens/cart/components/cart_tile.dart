import 'package:flutter/material.dart';

import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/screens/widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_service.dart';

import '../../../models/cart_item_model.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;
  final Function(CartItemModel) remove;

  const CartTile({
    Key? key,
    required this.cartItem,
    required this.remove,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsService utilsService = UtilsService();

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
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          utilsService.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: QuantityWidget(
          value: widget.cartItem.quantity,
          sufixText: widget.cartItem.item.unit,
          result: (quantity) {
            setState(() {
              widget.cartItem.quantity = quantity;

              if (quantity == 0) {
                widget.remove(widget.cartItem);
              }
            });
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
