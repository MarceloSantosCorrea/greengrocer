import 'package:get/get.dart';

import '../../../models/cart_item_model.dart';
import '../../../services/utils_service.dart';
import '../../auth/controller/auth.controller.dart';
import '../repository/cart_repository.dart';
import '../response/cart_response.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsService = UtilsService();

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartResponse<List<CartItemModel>> response =
        await cartRepository.getCartItens(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    response.when(
      success: (data) {
        // cartItems = data;
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
}
