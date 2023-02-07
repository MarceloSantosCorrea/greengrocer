import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/screens/widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_service.dart';

class ProductScreen extends StatelessWidget {
  final ItemModel item;
  final UtilsService utilsService = UtilsService();
  ProductScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: item.imgUrl,
                  child: Image.asset(item.imgUrl),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.itemName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const QuantityWidget(),
                        ],
                      ),
                      Text(
                        utilsService.priceToCurrency(item.price),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            child: Text(
                              item.description,
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.0,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {},
                          label: const Text(
                            'Add no carrinho',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(Icons.shopping_cart_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
