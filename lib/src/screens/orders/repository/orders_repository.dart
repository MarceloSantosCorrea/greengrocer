import '../../../constants/endpoints.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/order_model.dart';
import '../../../services/http_manager.dart';
import '../response/orders_response.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResponse<List<CartItemModel>>> getOrderItems({
    required String token,
    required String orderId,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      body: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (response['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(response['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrdersResponse<List<CartItemModel>>.success(items);
    } else {
      return OrdersResponse.error(
        'Ocorreu um erro ao recuperar os items do pedido',
      );
    }
  }

  Future<OrdersResponse<List<OrderModel>>> getAllOrders({
    required String token,
    required String userId,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (response['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(response['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResponse<List<OrderModel>>.success(orders);
    } else {
      return OrdersResponse.error(
        'Ocorreu um erro ao recuperar os pedidos',
      );
    }
  }
}
