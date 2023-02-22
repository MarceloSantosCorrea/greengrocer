import '../../../constants/endpoints.dart';
import '../../../services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

// <CartResponse<List>>
  Future getCartItens({
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
      print(response['result']);
      // CartResponse.success(data);
    } else {
      // CartResponse.error('');
    }
  }
}
