import 'package:get/get.dart';

import '../../auth/controller/auth.controller.dart';
import '../repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> getCartItems() async {
    await cartRepository.getCartItens(
      token: authController.user.token!,
      userId: authController.user.id!,
    );
  }
}
