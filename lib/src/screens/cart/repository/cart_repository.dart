import '../../../constants/endpoints.dart';
import '../../../models/cart_item_model.dart';
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

      return CartResponse.success(data);
    } else {
      return CartResponse.error(
        'Ocorreu um erro ao recuperar os dados do carrinho',
      );
    }
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
      return CartResponse.success(result['result']['id']);
    } else {
      return CartResponse.error(
        'Não foi possível adicionar item no carrinho',
      );
    }
  }
}
