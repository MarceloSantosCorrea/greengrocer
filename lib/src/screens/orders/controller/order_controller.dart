import 'package:get/get.dart';

import '../../../models/cart_item_model.dart';
import '../../../models/order_model.dart';
import '../../../services/utils_service.dart';
import '../../auth/controller/auth.controller.dart';
import '../repository/orders_repository.dart';
import '../response/orders_response.dart';

class OrderController extends GetxController {
  OrderModel order;
  OrderController(this.order);

  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsService = UtilsService();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;

    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final OrdersResponse<List<CartItemModel>> response =
        await ordersRepository.getOrderItems(
      token: authController.user.token!,
      orderId: order.id,
    );
    setLoading(false);

    response.when(
      success: (items) {
        order.items = items;
      },
      error: (message) {
        utilsService.showToast(message: message, isError: true);
      },
    );
  }
}
