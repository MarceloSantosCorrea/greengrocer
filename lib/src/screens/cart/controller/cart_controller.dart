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

        print(data);
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
    return cartItems.indexWhere((itemInList) => itemInList.id == item.id);
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      cartItems[itemIndex].quantity += quantity;
    } else {
      cartRepository.addItemToCart(
        userId: userId,
        token: token,
        productId: productId,
        quantity: quantity,
      );

      cartItems.add(
        CartItemModel(
          id: '',
          item: item,
          quantity: quantity,
        ),
      );
    }
    update();
  }
}
