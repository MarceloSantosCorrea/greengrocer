import '../../../constants/endpoints.dart';
import '../../../models/user_model.dart';
import '../../../services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  Future signIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (result['result'] != null) {
      print('Login funcionou');
      print(result['result']);
      final user = UserModel.fromMap(result['result']);

      print(user.toString());
    } else {
      print('Login não funcionou');
      print(result['error']);
    }
  }
}
