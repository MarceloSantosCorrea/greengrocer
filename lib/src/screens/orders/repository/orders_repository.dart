import '../../../constants/endpoints.dart';
import '../../../models/order_model.dart';
import '../../../services/http_manager.dart';
import '../response/orders_response.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResponse<List<OrderModel>>> getAllOrders({
    required String token,
    required String userId,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      body: {'user': userId},
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (response['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(response['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResponse.success(orders);
    } else {
      return OrdersResponse.error(
        'Ocorreu um erro ao recuperar os pedidos',
      );
    }
  }
}
