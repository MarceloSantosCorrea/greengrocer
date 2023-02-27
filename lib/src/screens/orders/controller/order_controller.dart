import 'package:get/get.dart';

import '../../../services/utils_service.dart';
import '../../auth/controller/auth.controller.dart';
import '../repository/orders_repository.dart';

class OrderController extends GetxController {
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsService = UtilsService();

  Future<void> getOrderItems({
    required String orderId,
  }) async {
    final response = await ordersRepository.getOrderItems(
      token: authController.user.token!,
      orderId: orderId,
    );

    response.when(
      success: (item) {},
      error: (message) {
        utilsService.showToast(message: message, isError: true);
      },
    );
  }
}
