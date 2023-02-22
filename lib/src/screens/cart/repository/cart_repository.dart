import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/screens/cart/response/cart_response.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResponse<List>> cartItens({
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
      // CartResponse.success(data);
    } else {
      CartResponse.error('');
    }
  }
}
