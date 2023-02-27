import '../../../constants/endpoints.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/order_model.dart';
import '../../../services/http_manager.dart';
import '../response/cart_response.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResponse<List<CartItemModel>>> getCartItens({
    required String token,
    required String userId,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'userId': userId,
      },
    );

    if (response['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(response['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResponse<List<CartItemModel>>.success(data);
    } else {
      return CartResponse.error(
        'Ocorreu um erro ao recuperar os dados do carrinho',
      );
    }
  }

  Future<CartResponse<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      body: {
        'total': total,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (response['result'] != null) {
      final order = OrderModel.fromJson(response['result']);
      return CartResponse<OrderModel>.success(order);
    } else {
      return CartResponse.error(
        'Ocorreu um erro ao realizar o pedido',
      );
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.changeItemQuantity,
      method: HttpMethods.post,
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return response.isEmpty;
  }

  Future<CartResponse<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      return CartResponse<String>.success(result['result']['id']);
    } else {
      return CartResponse.error(
        'Não foi possível adicionar item no carrinho',
      );
    }
  }
}
