import 'package:flutter/material.dart';

import '../../../config/custom_colors.dart';
import '../../../models/item_model.dart';
import '../../../services/utils_service.dart';
import '../../product/product_screen.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final UtilsService utilsService = UtilsService();

  final GlobalKey imageGk = GlobalKey();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (c) => ProductScreen(item: widget.item),
              ),
            );
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Image.asset(
                        widget.item.imgUrl,
                        key: imageGk,
                      ),
                    ),
                  ),
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        utilsService.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  print('clicou');
                  switchIcon();
                  widget.cartAnimationMethod(imageGk);
                },
                child: Ink(
                  child: Container(
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                      color: CustomColors.customSwatchColor,
                    ),
                    child: Icon(
                      tileIcon,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
