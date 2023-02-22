import 'package:flutter/material.dart';

import '../../../config/app_data.dart' as app_data;
import '../../../config/custom_colors.dart';
import '../../../models/cart_item_model.dart';
import '../../../services/utils_service.dart';
import '../../widgets/payment_dialog.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsService utilService = UtilsService();

  void removeItemFromCart(CartItemModel cartItem) {
    // setState(() {
    //   app_data.cartItems.remove(cartItem);
    //   utilService.showToast(
    //     message: '${cartItem.item.itemName} removido(a) do carrinho',
    //   );
    // });
  }

  double cartTotalPrice() {
    // double total = 0;

    // for (var item in app_data.cartItems) {
    //   total += item.totalPrice();
    // }

    // return total;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (_, index) {
                return Container();
                //   return CartTile(
                //   cartItem: app_data.cartItems[index],
                //   remove: removeItemFromCart,
                // );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  utilService.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (_) => PaymentDialog(
                            order: app_data.orders.first,
                          ),
                        );
                      } else {
                        utilService.showToast(
                          message: 'Pedido não confirmado',
                          isError: true,
                        );
                      }
                    },
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('sim'),
            ),
          ],
        );
      },
    );
  }
}
