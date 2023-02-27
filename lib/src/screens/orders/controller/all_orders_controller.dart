import 'package:get/get.dart';

import '../../../models/order_model.dart';
import '../../../services/utils_service.dart';
import '../../auth/controller/auth.controller.dart';
import '../repository/orders_repository.dart';
import '../response/orders_response.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final ordersRepository = OrdersRepository();
  final authRepository = Get.find<AuthController>();
  final utilsService = UtilsService();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResponse<List<OrderModel>> response =
        await ordersRepository.getAllOrders(
      token: authRepository.user.token!,
      userId: authRepository.user.id!,
    );

    response.when(
      success: (orders) {
        allOrders = orders;
        update();
      },
      error: (message) {
        utilsService.showToast(message: message, isError: true);
      },
    );
  }
}
