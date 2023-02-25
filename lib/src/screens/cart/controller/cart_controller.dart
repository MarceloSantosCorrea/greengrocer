import 'package:get/get.dart';

import '../../../models/cart_item_model.dart';
import '../../../models/item_model.dart';
import '../../../services/utils_service.dart';
import '../../auth/controller/auth.controller.dart';
import '../repository/cart_repository.dart';
import '../response/cart_response.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsService = UtilsService();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final response = await cartRepository.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    return response;
  }

  Future<void> getCartItems() async {
    final CartResponse<List<CartItemModel>> response =
        await cartRepository.getCartItens(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    response.when(
      success: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];

      final result = await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
      if (result) {
        cartItems[itemIndex].quantity += quantity;
      } else {
        utilsService.showToast(
          message: 'Ocorreu um erro ao alterar a quantidade do produto',
          isError: true,
        );
      }
    } else {
      final CartResponse<String> response = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      response.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilsService.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }
    update();
  }
}
